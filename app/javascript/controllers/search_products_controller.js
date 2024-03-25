import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-products"
export default class extends Controller {
  connect() {
    const searched_for = document.querySelector('#searched_for');
    if (searched_for) {
      searched_for.innerHTML = query.value;
    }
  }
}
