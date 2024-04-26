import { Controller } from "@hotwired/stimulus"
import application_controller from "./application_controller";


// Connects to data-controller="subscribe"
export default class extends application_controller {
  connect() {
    this.element.addEventListener("input", this.checkForm);
  }

  checkForm = () => {
    if (this.validateEmail()) {
      error.innerText = '';
      submitButton.className = "h-[44px] rounded-md text-white w-full bg-black font-bold outline outline-[1px] cursor-pointer hover:bg-hover active:ring-2  active:ring-offset-2 active:outline-none custom-focus"
    }
  }

  validateEmail() {
    return super.validateEmail(email);
  }

  showValidationForTarget(target, isValid) {
    super.showValidationForTarget(target, isValid);
  }

  submit(event) {
    event.preventDefault();
    if (this.validateEmail()) {
      console.log("subscription");
    }
  }

}
