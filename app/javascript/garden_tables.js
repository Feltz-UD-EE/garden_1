function cellValue(row, index) {
  return (row.cells[index]?.textContent || "").trim();
}

function compareValues(left, right, direction) {
  const leftNumber = Number(left.replace(/,/g, ""));
  const rightNumber = Number(right.replace(/,/g, ""));
  const bothNumeric = left !== "" && right !== "" && !Number.isNaN(leftNumber) && !Number.isNaN(rightNumber);

  if (bothNumeric) {
    return direction * (leftNumber - rightNumber);
  }

  return direction * left.localeCompare(right, undefined, { numeric: true, sensitivity: "base" });
}

function tableRows(table) {
  return Array.from(table.tBodies[0]?.rows || []);
}

function normalizeTable(table) {
  if (table.tHead && table.tBodies.length > 0) return;

  const rows = Array.from(table.rows);
  if (rows.length === 0) return;

  const head = table.createTHead();
  head.appendChild(rows[0]);

  const body = table.tBodies[0] || table.createTBody();
  rows.slice(1).forEach((row) => body.appendChild(row));
}

function visibleRows(rows, query) {
  if (!query) return rows;

  const normalizedQuery = query.toLowerCase();
  return rows.filter((row) => row.textContent.toLowerCase().includes(normalizedQuery));
}

function renderTable(state) {
  const rows = visibleRows(state.rows, state.query);
  const totalPages = Math.max(1, Math.ceil(rows.length / state.pageSize));
  state.page = Math.min(state.page, totalPages);

  const start = (state.page - 1) * state.pageSize;
  const end = start + state.pageSize;
  const visible = rows.slice(start, end);

  state.rows.forEach((row) => {
    row.hidden = !visible.includes(row);
  });

  state.summary.textContent = rows.length === 0
    ? "No matching rows"
    : "Showing " + (start + 1) + "-" + Math.min(end, rows.length) + " of " + rows.length;

  state.pagination.innerHTML = "";

  const pages = Array.from({ length: totalPages }, (_value, index) => index + 1).filter((page) => {
    return page === 1 || page === totalPages || Math.abs(page - state.page) <= 2;
  });

  let previousPage = 0;
  pages.forEach((page) => {
    if (page - previousPage > 1) {
      const gap = document.createElement("span");
      gap.textContent = "...";
      state.pagination.appendChild(gap);
    }

    const button = document.createElement("button");
    button.type = "button";
    button.textContent = page;
    if (page === state.page) button.setAttribute("aria-current", "page");
    button.addEventListener("click", () => {
      state.page = page;
      renderTable(state);
    });
    state.pagination.appendChild(button);
    previousPage = page;
  });
}

function initializeTable(table) {
  if (table.dataset.gardenTable === "true") return;

  normalizeTable(table);
  if (!table.tHead || !table.tBodies[0]) return;

  table.dataset.gardenTable = "true";
  table.classList.add("garden-table");

  const wrapper = document.createElement("div");
  wrapper.className = "garden-table-wrap";
  table.parentNode.insertBefore(wrapper, table);
  wrapper.appendChild(table);

  const controls = document.createElement("div");
  controls.className = "garden-table-controls";
  controls.innerHTML = '<label>Filter <input type="search" autocomplete="off"></label><label>Rows <select><option>10</option><option>25</option><option>50</option><option value="999999">All</option></select></label>';
  wrapper.parentNode.insertBefore(controls, wrapper);

  const footer = document.createElement("div");
  footer.className = "garden-table-footer";
  footer.innerHTML = '<span></span><nav class="garden-table-pagination" aria-label="Table pages"></nav>';
  wrapper.parentNode.insertBefore(footer, wrapper.nextSibling);

  const requestedPageSize = table.dataset.pageSize === "all" ? 999999 : Number(table.dataset.pageSize);
  const pageSize = Number.isFinite(requestedPageSize) && requestedPageSize > 0 ? requestedPageSize : 10;

  const state = {
    rows: tableRows(table),
    page: 1,
    pageSize: pageSize,
    query: "",
    summary: footer.querySelector("span"),
    pagination: footer.querySelector(".garden-table-pagination")
  };

  controls.querySelector("select").value = pageSize === 999999 ? "999999" : String(pageSize);

  Array.from(table.tHead.rows[0].cells).forEach((cell, index) => {
    const button = document.createElement("button");
    button.type = "button";
    button.className = "garden-table-sort";
    button.textContent = cell.textContent.trim();
    button.setAttribute("aria-sort", "none");
    cell.textContent = "";
    cell.appendChild(button);

    button.addEventListener("click", () => {
      const currentSort = button.getAttribute("aria-sort");
      const direction = currentSort === "ascending" ? -1 : 1;

      table.querySelectorAll(".garden-table-sort").forEach((sortButton) => {
        sortButton.setAttribute("aria-sort", "none");
      });

      button.setAttribute("aria-sort", direction === 1 ? "ascending" : "descending");
      state.rows.sort((left, right) => compareValues(cellValue(left, index), cellValue(right, index), direction));
      state.rows.forEach((row) => table.tBodies[0].appendChild(row));
      state.page = 1;
      renderTable(state);
    });
  });

  controls.querySelector("input").addEventListener("input", (event) => {
    state.query = event.target.value.trim();
    state.page = 1;
    renderTable(state);
  });

  controls.querySelector("select").addEventListener("change", (event) => {
    state.pageSize = Number(event.target.value);
    state.page = 1;
    renderTable(state);
  });

  renderTable(state);
}

function initializeGardenTables() {
  document.querySelectorAll("table.datatable, table.garden-page__table").forEach(initializeTable);
}

document.addEventListener("DOMContentLoaded", initializeGardenTables);
document.addEventListener("turbo:load", initializeGardenTables);
