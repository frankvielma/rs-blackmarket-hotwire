import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sign-out"
export default class extends Controller {
  signOut() {
    window.location.href = "/sign_out";
  }
}
