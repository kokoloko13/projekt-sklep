let alertContainer = document.getElementsByClassName("alert")[0];
let alertMessage = document.getElementsByClassName("alertMessage")[0];
let alertProductName = document.getElementsByClassName("productAlertName")[0];

let alertClose = document.querySelector(".alert > i");

function AddToCartNotification(productName) {
  alertProductName.innerHTML = productName;

  showNotification();

  setTimeout(hideNotification, 3000);
}

function showNotification() {
  alertContainer.classList.add("active");
  animateCSS(alertContainer, "slideInDown");
}

function hideNotification() {
  animateCSS(alertContainer, "slideOutUp");
  setTimeout(() => {
    alertContainer.classList.remove("active");
  }, 450);
}

alertClose.addEventListener("click", hideNotification);
