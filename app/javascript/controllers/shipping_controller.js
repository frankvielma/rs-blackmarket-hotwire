import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shipping"
export default class extends Controller {
  cancel() {
    Turbo.visit('/shopping_cart/index');
  }

  billing() {
    billingAddress.classList.toggle('hidden');
  }
}
