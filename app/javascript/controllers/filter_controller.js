import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  toggle() {
    const filter = document.querySelector(".filter-menu");
    filter.classList.toggle("hidden"); 
    products = document.querySelector("#products");
    products.classList.toggle("hidden");
  }
}
