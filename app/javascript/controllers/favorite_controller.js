import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite"
export default class extends Controller {
  static values = { product_id: Number }

  handleKeyPress(event) {
    const productId = this.productIdValue;
    if ((event.key === ' ') || (event.key === 'Enter')) {
      event.preventDefault();
      this.sendFavoriteRequest(`/products/${productId}/favorite`, { favorite: this.isFavorite });
    }
  }

  togglefavorite(event) {
    const productId = this.productIdValue;
    this.sendFavoriteRequest(`/products/${productId}/favorite`, { favorite: this.isFavorite });
  }
  
  sendFavoriteRequest(url, data) {
    fetch(url, {
      method: "POST",
      headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content },
      body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => {
      const button = this.element.querySelector('button').children;
      button[0].classList.toggle('hidden');
      button[1].classList.toggle('hidden');
    });
  }

}