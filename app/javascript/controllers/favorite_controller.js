import { Controller } from "@hotwired/stimulus"
import application_controller from "./application_controller";

// Connects to data-controller="favorite"
export default class extends application_controller {
  static values = { product_id: Number }

  handleKeyPress(event) {
    let url = `/products/${productId}/favorite`;
    super.handleKeyPress(event, url);
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
