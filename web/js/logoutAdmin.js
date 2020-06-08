let logoutButton = document.getElementById("logout");

logoutButton.addEventListener("click", () => {
        const Http = new XMLHttpRequest();
        const url = '/AdminLogout';
        Http.open("GET", url);
        Http.send();
window.location.replace("/cpanel/admin-login.jsp");
});