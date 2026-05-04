# Moisture Summary Rollout - 2026-05-03

## Conversation Summary

This branch adds compact historical storage for moisture readings. The goal is to keep recent/current-year moisture readings raw for normal charting and troubleshooting, while summarizing completed calendar years into daily per-zone records so the Raspberry Pi SQLite database stays small and responsive.

The design choices we settled on:

- Summarize by completed calendar year, not rolling 365-day age.
- Preserve the zone relationship directly on each daily summary.
- Preserve historical crop context through a join table linking each summary to the crop or crops planted in that zone on that day.
- Store daily min, max, average, standard deviation, plus/minus two-sigma bounds, and tail counts.
- Delete raw moisture readings only after their daily summaries and crop links have been written.
- Process old data in small chunks so SQLite does not lock the Raspberry Pi for a long time.

## What Changes In The Database

The migrations add:

- `moisture_reading_daily_summaries`
- `moisture_reading_daily_summary_crops`
- an index on `moisture_readings(created_at, zone_id)`
- a unique index on `moisture_reading_daily_summaries(zone_id, day)`
- a unique index on `moisture_reading_daily_summary_crops(moisture_reading_daily_summary_id, crop_id)`

Existing `moisture_readings` rows are not summarized or deleted when Rails starts.

## Important Date Rule

The summarizer keeps the current calendar year in raw form.

On May 3, 2026:

- raw readings from January 1, 2026 through today remain raw
- readings before January 1, 2026 are eligible to summarize and prune

On January 1, 2027:

- 2026 readings become eligible to summarize and prune
- 2027 readings remain raw

## Manual Rollout Steps After Merge

Run these on the Raspberry Pi after merging the branch.

### 1. Stop The Rails Server

If Rails is running, stop it first. This avoids competing SQLite traffic while the migration creates indexes.

### 2. Back Up The Database

From the project directory:

```sh
cp db/development.sqlite3 db/development.sqlite3.before_moisture_summary_2026_05_03
```

Use the actual database file for the environment you run on the Pi if it is not `db/development.sqlite3`.

### 3. Run Migrations

```sh
bundle exec rails db:migrate
```

This creates the new summary tables and indexes. The `moisture_readings(created_at, zone_id)` index may take a while if the table has readings back to 2021.

### 4. Run A Small Smoke-Test Batch

Run a tiny catch-up first:

```sh
bundle exec rails moisture_readings:catch_up_previous_years MAX_RUNTIME_MINUTES=2 SLEEP_SECONDS=1
```

Then inspect Maintenance -> Data Retention in the browser. You should see:

- Total Raw Readings
- Before This Year
- Daily Summaries
- Summary Crop Links

Raw readings before January 1 of the current year should start decreasing. Daily summaries and crop links should start increasing.

### 5. Run The Main Catch-Up

If the small batch behaves normally, run:

```sh
bundle exec rails moisture_readings:catch_up_previous_years MAX_RUNTIME_MINUTES=30 SLEEP_SECONDS=1
```

This command processes one calendar day at a time, commits each day separately, sleeps between days, and stops when either:

- there are no more eligible raw readings before January 1 of the current year, or
- the runtime limit is reached

It is safe to run the same command again. It resumes from the oldest remaining raw day.

For a large backlog from 2021 through 2025, repeat the same command until Maintenance -> Data Retention shows `Before This Year` near zero.

If the Raspberry Pi stays responsive, you can use a longer runtime:

```sh
bundle exec rails moisture_readings:catch_up_previous_years MAX_RUNTIME_MINUTES=120 SLEEP_SECONDS=0.5
```

Avoid running an unlimited catch-up with no sleeps.

### 6. Reclaim SQLite Disk Space Later

SQLite may not immediately return deleted-row space to the filesystem. After the catch-up is complete, run `VACUUM` during a quiet maintenance window.

Stop Rails first, then run:

```sh
bundle exec rails db
```

In the SQLite prompt:

```sql
VACUUM;
.quit
```

This can take a while and can temporarily need extra disk space, so do it only after confirming there is enough free storage.

### 7. Start Rails Again

```sh
bundle exec rails s
```

## Future Annual Schedule

After this catch-up is done, add cron so the Pi summarizes completed years every January.

Example: run every day in January at 2:30 AM, processing up to 30 old days per run.

```cron
30 2 * 1 * cd /path/to/garden_1 && bundle exec rails moisture_readings:summarize_previous_years MAX_DAYS=30 SLEEP_SECONDS=0.5
```

That should summarize the previous calendar year over roughly two weeks without one large SQLite transaction.

## Manual UI Option

Maintenance -> Data Retention also has a `Summarize 3 Days` button.

That is useful for small manual checks, but it is not intended for the multi-year backlog. Use the catch-up rake task for that.
