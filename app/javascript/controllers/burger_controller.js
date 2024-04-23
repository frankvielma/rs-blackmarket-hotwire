import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    const burger = document.querySelectorAll(".navbar-burger");
    const menu = document.querySelectorAll(".navbar-menu");

    if (burger.length && menu.length) {
      burger.forEach((item) => item.addEventListener("click", () => {
        menu.forEach((menuItem) => menuItem.classList.toggle("hidden"));
      }));
    }

    const close = document.querySelectorAll(".navbar-close");

    if (close.length) {
      close.forEach((item) => item.addEventListener("click", () => {
        menu.forEach((menuItem) => menuItem.classList.toggle("hidden"));
      }));
    }
  }
}

