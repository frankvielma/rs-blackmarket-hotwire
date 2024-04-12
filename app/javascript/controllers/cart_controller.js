import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="cart"
export default class extends Controller {
  static values = { product_id: Number };
  static targets = [ "slide" ];

  handleKeyPress(event) {
    const productId = this.productIdValue;
    if ((event.key === ' ') || (event.key === 'Enter')) {
      event.preventDefault();
      this.sendCartRequest(`/products/${productId}/shopping_carts`, { cart: this.isFavorite });
    }
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
