import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="signin"
export default class extends Controller {

  submit(event) {
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
