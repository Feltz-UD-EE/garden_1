function closeMenuItem(item) {
  const button = item.querySelector(".garden-nav__button");
  const dropdown = item.querySelector(".garden-nav__dropdown");

  if (!button || !dropdown) return;

  button.setAttribute("aria-expanded", "false");
  dropdown.hidden = true;
}

function openMenuItem(item) {
  const button = item.querySelector(".garden-nav__button");
  const dropdown = item.querySelector(".garden-nav__dropdown");

  if (!button || !dropdown) return;

  button.setAttribute("aria-expanded", "true");
  dropdown.hidden = false;
}

function initializeGardenNavigation() {
  const nav = document.querySelector(".garden-nav");
  if (!nav || nav.dataset.initialized === "true") return;

  nav.dataset.initialized = "true";

  const menuToggle = nav.querySelector(".garden-nav__toggle");
  const menuItems = Array.from(nav.querySelectorAll(".garden-nav__item"));

  menuToggle?.addEventListener("click", () => {
    const isOpen = nav.classList.toggle("garden-nav--open");
    menuToggle.setAttribute("aria-expanded", String(isOpen));
  });

  menuItems.forEach((item) => {
    const button = item.querySelector(".garden-nav__button");

    button?.addEventListener("click", () => {
      const isExpanded = button.getAttribute("aria-expanded") === "true";

      menuItems.forEach((otherItem) => {
        if (otherItem !== item) closeMenuItem(otherItem);
      });

      if (isExpanded) {
        closeMenuItem(item);
      } else {
        openMenuItem(item);
      }
    });
  });

  document.addEventListener("click", (event) => {
    if (nav.contains(event.target)) return;

    menuItems.forEach(closeMenuItem);
    nav.classList.remove("garden-nav--open");
    menuToggle?.setAttribute("aria-expanded", "false");
  });

  document.addEventListener("keydown", (event) => {
    if (event.key !== "Escape") return;

    menuItems.forEach(closeMenuItem);
    nav.classList.remove("garden-nav--open");
    menuToggle?.setAttribute("aria-expanded", "false");
    menuToggle?.focus();
  });
}

document.addEventListener("turbo:load", initializeGardenNavigation);
document.addEventListener("DOMContentLoaded", initializeGardenNavigation);
