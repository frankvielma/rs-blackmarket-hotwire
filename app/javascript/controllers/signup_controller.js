import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="signup"
export default class extends Controller {
  connect() {
    this.element.addEventListener("input", this.checkForm)
  }

  checkForm = () => {
    if (this.validateEmail() && this.validatePassword() && this.ValidateConfirmPassword()) {
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

  ValidateConfirmPassword() {
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

  submit(event) {
    event.preventDefault();

    const submitButton = document.getElementById("submitButton");
    const isSubmitDisabled =
      submitButton.className.includes("cursor-not-allowed");

    if (isSubmitDisabled) {
      return;
    }

    const form = this.element;
    const email = form.email.value;
    const password = form.password.value;
    const confirm_password = form.confirm_password.value;

    fetch("https://rs-blackmarket-api.herokuapp.com/api/v1/users", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        user: {
          email: email,
          password: password,
          password_confirmation: confirm_password,
        },
      }),
    })
      .then((response) => {
        if (response.ok) {
          signOut(response.headers);
        }
        return response.json();
      })
      .then((data) => {
        if (data.status === "error") {
          const error = document.getElementById("error");
          error.innerHTML = data.errors.full_messages[0];
          error.className = "visible text-red-500 text-center";
        } else {
          console.log("Success:", data);
        }
      })
      .catch((error) => {
        console.error("Error:", error);
      });
  }
}

function signOut(headers) {
  const uid = headers.get("uid");
  const access_token = headers.get("access-token");
  const client = headers.get("client");
  fetch("/sign_up/", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
    },
    body: JSON.stringify({
      email: uid,
      access_token: access_token,
      client: client,
    }),
  })
    .then((response) => response.json())
    .then((data) => {
      const error = document.getElementById("error");
      error.innerHTML = "Account created successfully";
      error.className = "visible text-blue-500 text-center";
      setTimeout(() => {
        window.location.href = "/login";
      }, 2000);
    })
    .catch((error) => {
      console.log("error = ", error);
    });
}
