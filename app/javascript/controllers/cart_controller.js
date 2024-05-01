import { Controller } from "@hotwired/stimulus"
import application_controller from "./application_controller";

// Connects to data-controller="cart"
export default class extends application_controller {
  static values = { product_id: Number };
  static targets = [ "slide" ];

  handleKeyPress(event) {
    let url = `/products/${productId}/shopping_carts`;
    super.handleKeyPress(event, url);
  }

  togglecart(event) {
    const productId = this.productIdValue;
    this.slideTargets[0].classList.toggle('text-white');
    this.slideTargets[0].classList.toggle('bg-black');
    this.slideTargets[0].classList.toggle('border');
    this.slideTargets[0].classList.toggle('text-black');
    this.slideTargets[0].classList.toggle('bg-white');
    this.sendCartRequest(`/products/${productId}/shopping_carts`, { cart: this.isFavorite });
  }

  sendCartRequest(url, data) {
    fetch(url, {
      method: "POST",
      headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content },
      body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => {

    });
  }

}
