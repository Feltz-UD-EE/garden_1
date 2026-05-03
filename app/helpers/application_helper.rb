module ApplicationHelper
  def primary_navigation
    [
      {
        label: "Garden",
        icon: "eco",
        controllers: %w[static tanks zones crops events notes],
        children: [
          { label: "Home", path: public_home_path },
          { label: "Tanks", path: tanks_path },
          { label: "Zones", path: zones_path },
          { label: "Current Crops", path: crops_path },
          { label: "Past Crops", path: crops_path(past: true) },
          { label: "Events", path: events_path },
          { label: "Notes", path: notes_path }
        ]
      },
      {
        label: "Retrospectives",
        icon: "insights",
        controllers: %w[retrospectives],
        children: [
          { label: "Overview", path: retrospectives_path },
          { label: "Crop Performance", path: retrospective_crops_path },
          { label: "Garden by Year", path: retrospective_garden_path },
          { label: "Harvest Trends", path: retrospective_harvests_path },
          { label: "Moisture History", path: retrospective_moisture_path }
        ]
      },
      {
        label: "Maintenance",
        icon: "build",
        controllers: %w[maintenance],
        children: [
          { label: "Overview", path: maintenance_path },
          { label: "Sensor Status", path: maintenance_sensors_path },
          { label: "Data Retention", path: maintenance_data_retention_path },
          { label: "Backup / Export", path: maintenance_backups_path },
          { label: "System Notes", path: maintenance_notes_path }
        ]
      }
    ]
  end

  def navigation_item_active?(item)
    item.fetch(:controllers, []).include?(controller_name) ||
      current_page?(item[:path]) ||
      item.fetch(:children, []).any? { |child| current_page?(child[:path]) }
  end
end
