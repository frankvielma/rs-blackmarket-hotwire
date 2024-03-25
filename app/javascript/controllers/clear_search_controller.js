import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clear-search"
export default class extends Controller {
  clearSearch() {
    const searchInputs = document.querySelectorAll('#query');
    searchInputs.forEach(input => input.value = '');
  }

}
