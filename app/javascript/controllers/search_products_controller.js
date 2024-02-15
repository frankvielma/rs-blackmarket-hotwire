import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-products"
export default class extends Controller {
  connect() {
    const searched = window.innerWidth > 640 ? document.getElementById('searched-for-desktop') : document.getElementById('searched-for-mobile');
    if (searched) {
      const query = window.innerWidth > 640 ? document.getElementById('query-desktop').value : document.getElementById('query-mobile').value;
      searched.innerHTML = query;
    }
  }
}
