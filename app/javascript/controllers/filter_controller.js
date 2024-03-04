import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ["category", "submitForm"]

  toggle() {
    const filter = document.querySelector(".filter-menu");
    filter.classList.toggle("hidden"); 
    products = document.querySelector("#products");
    products.classList.toggle("hidden");
  }

  categories() {
    const value = this.categoryTarget.value;
    fetch(`/categories/search?name=${value}`, {
      contentType: 'application/json',
      hearders: 'application/json'
    })
    .then((response) => response.text())
    .then(res => {
      const list = window.innerWidth > 640 ? listDesktop : listMobile;
      list.innerHTML = res;
    })
  }


  select(event) {
    this.submitFormTarget.submit();
  }
}
