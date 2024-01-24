import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="signup"
export default class extends Controller {

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
