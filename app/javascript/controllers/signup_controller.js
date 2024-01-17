import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="signup"
export default class extends Controller {

  connect() {
    const email = document.getElementById("email");
    email.addEventListener("blur", ValidateEmail, true);

    const password = document.getElementById("password");
    password.addEventListener("blur", ValidatePassword, true);

    const confirm_password = document.getElementById("confirm_password");
    confirm_password.addEventListener("blur", ValidateConfirmPassword, true);


    const form = document.getElementById("signUpForm");
    form.addEventListener("input", function() {
      const error = document.getElementById('error'); 
      const submitButton = document.getElementById("submitButton");

      submitButton.className = (ValidateEmail() && ValidatePassword() && ValidateConfirmPassword()) 
      ? "h-[44px] rounded-md text-white w-full bg-black font-bold text-white outline-none cursor-pointer"
      : "h-[44px] rounded-md text-white w-full bg-light-gray font-bold text-white outline-none cursor-not-allowed";
    });

    /**
     * Validates an email address.
     *
     * @return {boolean} true if the email address is valid, false otherwise
     */
    function ValidateEmail() {
      const emailInput = email.value;
      const regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
      const isValid = regex.test(emailInput);
      const error = document.getElementById('error'); 

      error.innerHTML = isValid ? '' : 'Invalid email address.';
      error.className = isValid ? "invisible text-red-500 text-center" : "visible text-red-500 text-center";
      return isValid;
    }

    /**
     * Validates the password input and updates the error message accordingly.
     *
     * @return {boolean} Returns true if the password is valid, false otherwise.
     */
    function ValidatePassword() {
      const passwordInput = password.value;
      const isValid = passwordInput.length >= 8;
      const error = document.getElementById('error'); 

      error.innerHTML = isValid ? '' : 'Password must be at least 8 characters long.';
      error.className = isValid ? "invisible text-red-500 text-center" : "visible text-red-500 text-center";
      return isValid;
    }

    /**
     * Validates the confirm password input field.
     *
     * @return {boolean} Returns true if the password is valid and matches the confirm password.
     */
    function ValidateConfirmPassword() {
      const confirmPasswordInput = confirm_password.value;
      const error = document.getElementById('error'); 

      const isPasswordLengthValid = confirmPasswordInput.length >= 8;
      const doPasswordsMatch = password.value === confirmPasswordInput;

      error.innerHTML = isPasswordLengthValid ? '' : 'Confirm password must be at least 8 characters long.';
      error.className = isPasswordLengthValid ? "invisible text-red-500 text-center" : "visible text-red-500 text-center";

      error.innerHTML = doPasswordsMatch ? '' : 'Passwords do not match.';
      error.className = doPasswordsMatch ? "invisible text-red-500 text-center" : "visible text-red-500 text-center";

      return isPasswordLengthValid && doPasswordsMatch
    }
  }

  submit(event) {
    event.preventDefault();

    const submitButton = document.getElementById("submitButton");
    const isSubmitDisabled = submitButton.className.includes('cursor-not-allowed')

    if (isSubmitDisabled) {
      return;
    }

    const form = this.element;
    const email = form.email.value;
    const password = form.password.value;
    const confirm_password = form.confirm_password.value;

    fetch('https://rs-blackmarket-api.herokuapp.com/api/v1/users', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(
        {
          user: {
            email: "axel@test.com",
            password: password,
            password_confirmation: confirm_password
          }
        })
    })
    .then(response => {
      return response.json();
    })
    .then(data => {
      if (data.status === 'error') {
        const error = document.getElementById('error'); 
        error.innerHTML = data.errors.full_messages[0];
        error.className = "visible text-red-500 text-center";
      } else {
        console.log('Success:', data);
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
  }
}
