import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clear-search"
export default class extends Controller {
  clearSearch() {
    const query = window.innerWidth > 640 ? document.getElementById('query-desktop') : document.getElementById('query-mobile');
    query.value = '';
  }

}
