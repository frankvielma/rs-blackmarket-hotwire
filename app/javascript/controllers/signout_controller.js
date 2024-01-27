import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="signout"
export default class extends Controller {
  toggleDropdown() {
    dropdownMenu.classList.toggle('hidden');
    arrowDown.classList.toggle('hidden');
    arrowUp.classList.toggle('hidden');
  }
}
