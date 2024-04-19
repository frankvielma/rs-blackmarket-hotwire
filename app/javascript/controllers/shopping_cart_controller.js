import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shopping-cart"
export default class extends Controller {
  static values = { product_id: String };

  remove() {
    console.log("id: ", this.productIdValue);

    let url = "/shopping_cart/" + this.productIdValue;
    let data = { id: this.productIdValue };

    fetch(url, {
      method: "DELETE",
      headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content },
      body: JSON.stringify(data)
    })
      .then(response => response)
  .then(data => {
      Turbo.visit('/shopping_cart/index', { progress: false });
    });
  }

}
