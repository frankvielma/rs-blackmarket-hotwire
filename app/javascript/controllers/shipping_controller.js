import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shipping"
export default class extends Controller {
  static tar

  cancel() {
    Turbo.visit('/shopping_cart/index');
  }

  billing() {
    billingAddress.classList.toggle('hidden');
  }

}
