import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="validate-form"
export default class extends Controller {
  connect() {
    this.element.addEventListener("input", this.checkForm);
  }

  checkForm = () => {
    let isValid = this.validateEmail() && this.validatePassword()
    if (typeof confirm_password !== "undefined") {
      isValid = isValid && this.validateConfirmPassword()
    }
    if (isValid) {
      error.innerText = '';
      submitButton.className = "h-[44px] rounded-md text-white w-full bg-black font-bold text-white outline-none cursor-pointer active:ring-2 active:ring-offset-2 active:outline-none custom-focus hover:bg-hover active:bg-hover"
    }
  }

  validateEmail() {
    const emailRegex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/
    const isValid = emailRegex.test(email.value);
    this.showValidationForTarget('email', isValid)
    return isValid
  }

  validatePassword() {
    const isValid = password.value.length >= 8
    this.showValidationForTarget('password', isValid)
    return isValid
  }

  validateConfirmPassword() {
    const confirmPasswordInput = confirm_password.value;
    const isPasswordLengthValid = confirmPasswordInput.length >= 8;
    const doPasswordsMatch = password.value === confirmPasswordInput;

    this.showValidationForTarget('password', isPasswordLengthValid)

    error.innerHTML = doPasswordsMatch ? "" : "Passwords do not match.";
    error.className = doPasswordsMatch
      ? "invisible text-red-500 text-center"
      : "visible text-red-500 text-center";

    return isPasswordLengthValid && doPasswordsMatch;
  }

  findVisibilityOff() {
    return this.element.querySelectorAll('[class*="visibility_off"]');
  }

  findVisibilityOn() {
    return this.element.querySelectorAll('[class*="visibility_on"]');
  }

  toggleVisibility(event) {
    if (password.type === "password") {
      this.findVisibilityOff().forEach(img => img.classList.add('hidden'));
      this.findVisibilityOn().forEach(img => img.classList.remove('hidden'));
      password.type = "text";
      if (typeof confirm_password !== "undefined") {
        confirm_password.type = "text";
      }
    } else {
      this.findVisibilityOff().forEach(img => img.classList.remove('hidden'));
      this.findVisibilityOn().forEach(img => img.classList.add('hidden'));
      password.type = "password";
      if (typeof confirm_password !== "undefined") {
        confirm_password.type = "password";
      }
    }
  }
   
  showValidationForTarget(target, isValid) {
    let errorMessage = ''

    if (target === 'email') {
      errorMessage = "Invalid email address.";
    }
    if (target === 'password') {
      errorMessage = "Password must be at least 8 characters long.";
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

}
