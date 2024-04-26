import { Controller } from "@hotwired/stimulus"
import application_controller from "./application_controller";

// Connects to data-controller="validate-form"
export default class extends application_controller {
  connect() {
    this.element.addEventListener("input", this.checkForm);
    submitButton.disabled = true;
  }

  checkForm = () => {
    let [user_email1, user_password1, user_password_confirmation1] = this.admin_form();
    let isValid = this.validateEmail(user_email1) && this.validatePassword(user_password1);
    if (typeof user_password_confirmation1 !== "undefined") {
      isValid = isValid && this.validateConfirmPassword(user_password1, user_password_confirmation1)
    }
    if (isValid) {
      error.innerText = "";
      submitButton.disabled = false;
      alertText.classList.add("hidden");
      submitButton.className = "h-[44px] rounded-md text-white w-full bg-black font-bold text-white outline-none cursor-pointer active:ring-2 active:ring-offset-2 active:outline-none custom-focus hover:bg-hover active:bg-hover"
    }
  };

  admin_form() {
    if (typeof new_admin_user !== "undefined") {
      var {user_email1, user_password1, user_password_confirmation1} = this.admin_user_form();
    } else {
      var {user_email1, user_password1, user_password_confirmation1} = this.user_form();
    }
    return [user_email1, user_password1, user_password_confirmation1];
  }

  admin_user_form() {
    let user_email1 = admin_user_email;
    let user_password1 = admin_user_password;
    if (typeof admin_user_password_confirmation !== "undefined") {
      var user_password_confirmation1 = admin_user_password_confirmation;
    }
    return {user_email1, user_password1, user_password_confirmation1};
  }

  user_form() {
    let user_email1 = user_email;
    let user_password1 = user_password;
    if (typeof user_password_confirmation !== "undefined") {
      var user_password_confirmation1 = user_password_confirmation;
    }
    return {user_email1, user_password1, user_password_confirmation1};
  }

  validateEmail(user_email1) {
    return super.validateEmail(user_email1);
  }

  validatePassword(user_password) {
    const isValid = user_password.value.length >= 8;
    this.showValidationForTarget('password', isValid);
    return isValid
  }

  validateConfirmPassword(user_password, user_password_confirmation) {
    const confirmPasswordInput = user_password_confirmation.value;
    const isPasswordLengthValid = confirmPasswordInput.length >= 8;
    const doPasswordsMatch = user_password.value === confirmPasswordInput;

    this.showValidationForTarget('password', isPasswordLengthValid);

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
    let [user_email1, user_password1, user_password_confirmation1] = this.admin_form();
    const isCurrentlyPassword = user_password1.type === "password";
    const newType = isCurrentlyPassword ? "text" : "password";

    this.findVisibilityOff().forEach(img => img.classList.toggle('hidden'));
    this.findVisibilityOn().forEach(img => img.classList.toggle('hidden'));

    user_password1.type = newType;
    if (typeof user_password_confirmation1 !== "undefined") {
      user_password_confirmation1.type = newType;
    }
  }

  showValidationForTarget(target, isValid) {
    super.showValidationForTarget(target, isValid);
  }

}
