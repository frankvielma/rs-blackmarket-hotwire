import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="subscribe"
export default class extends Controller {
  connect() {
    this.element.addEventListener("input", this.checkForm);
  }

  checkForm = () => {
    if (this.validateEmail()) {
      error.innerText = '';
      submitButton.className = "h-[44px] rounded-md text-white w-full bg-black font-bold outline outline-[1px] cursor-not-allowed active:ring-2 active:ring-offset-2 active:outline-none custom-focus"
    }
  }

  validateEmail() {
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/
    const isValid = emailRegex.test(email.value);
    this.showValidationForTarget('email', isValid)
    return isValid
  }

  showValidationForTarget(target, isValid) {
    let errorMessage = ''

    if (target === 'email') {
      errorMessage = "Invalid email address.";
    }
    if (isValid) {
      error.classList.remove("visible")
      error.classList.add("invisible")
    } else {
      error.innerText = errorMessage;
      error.classList.add("visible");
      error.classList.remove("invisible")
      submitButton.className = "h-[44px] rounded-md text-white w-full bg-light-gray font-bold text-white outline-none cursor-not-allowed";
    }
  }

  submit(event) {
    event.preventDefault();
    if (this.validateEmail()) {
      console.log("subscription");
    }
  }

}
