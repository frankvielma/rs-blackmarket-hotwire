import {Controller} from "@hotwired/stimulus"

// Connects to data-controller="shopping-cart"
export default class extends Controller {
  static values = {product_id: String};

  remove() {
    let url = "/shopping_cart/" + this.productIdValue;
    let data = {id: this.productIdValue};
    this.fetch_(url, data, 'DELETE');
  }

  add() {
    this.operation('add');
  }

  substract() {
    this.operation('substract');
  }


  operation(type) {
    let url = "/shopping_cart/update/" + this.productIdValue + '/' + type;
    let data = {id: this.productIdValue};

    this.fetch_(url, data, 'PUT');
  }

  fetch_(url, data, method) {
    fetch(url, {
      method: method,
      headers: {"X-CSRF-Token": document.querySelector("[name='csrf-token']").content},
      body: JSON.stringify(data)
    })
      .then(response => response)
      .then(data => {
        Turbo.visit('/shopping_cart/index');
      });
  }

}
