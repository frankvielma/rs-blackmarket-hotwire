import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="signin"
export default class extends Controller {
  connect() {
    this.element.addEventListener("input", this.checkForm);
  }

  checkForm = () => {
    if (this.validateEmail() && this.validatePassword()) {
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

  validateForm(event) {
    event.preventDefault();

    fetch('https://rs-blackmarket-api.herokuapp.com/api/v1/users/sign_in', {
      method: 'POST',
      mode: "cors",
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(
        {
          user: {
            email: email.value,
            password: password.value
          }
        })
    })
    .then(response => {
      if (response.ok) {
        signIn(response.headers);
      }
      return response.json();
    })
    .then(data => {
      if (data.error) {
        error.innerHTML = data.error;
        error.classList.add("visible");
        error.classList.remove("invisible");
      } else {
        console.log('Success!');
      }
    })
    .catch(error => {
      console.error('Error:', error);
    });
    
  }
}

function signIn(headers) {
  const uid  = headers.get('uid');
  const access_token = headers.get('access-token');
  const client = headers.get('client');
  fetch('/sign_in/', {
    method: 'POST',
    headers: { 
      'Content-Type': 'application/json', 
      'X-CSRF-Token': document.querySelector("[name='csrf-token']").content 
    },
    body: JSON.stringify(
      {
        email: uid,
        access_token: access_token,
        client: client
      })
  })
    .then(response => response.json())
    .then(data => {
      window.location.href = "/dashboard";
    })
    .catch(error => {
      console.log("error = ", error);
    });
}
