import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorite"
export default class extends Controller {


  togglefavorite(event) {
    const productId = event.target.id.split('-')[1]

    fetch(`/products/${productId}/favorite`, {
      method: "POST",
      headers: { "X-CSRF-Token": document.querySelector("[name='csrf-token']").content },
      body: JSON.stringify({ favorite: this.isFavorite })
    })
      .then(response => response.json())
      .then(data => {
        this.element.children[0].classList.toggle('hidden');
        this.element.children[1].classList.toggle('hidden');
      })

  }
}
