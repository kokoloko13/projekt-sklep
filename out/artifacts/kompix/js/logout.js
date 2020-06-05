let logoutButton = document.getElementById("logout");

logoutButton.addEventListener("click", async function() {
        let response = await fetch('/Logout');
        let data = await response.json();
        return data;
});