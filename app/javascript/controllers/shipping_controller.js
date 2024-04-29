import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shipping"
export default class extends Controller {
  connect() {
    
  }

  cancel() {
    Turbo.visit('/shopping_cart/index');
  }

}
