let logoutButton = document.getElementById("logoutAccount");

logoutButton.addEventListener("click", () => {
    const Http = new XMLHttpRequest();
const url = '/Logout';
Http.open("GET", url);
Http.send();
window.location.replace("/");
});