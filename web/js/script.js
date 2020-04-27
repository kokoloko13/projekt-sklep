function setCartBadge() {
  let cartBadge = document.getElementsByClassName("cart_badge")[0];

  let cartQty = 0;

  for(let i = 0; i < localStorage.length; i++){
    if(localStorage.getItem("koszyk_"+i) !== null){
      cartQty++;
    }
  }

  cartBadge.innerHTML = cartQty;
}

setCartBadge();

if (window.innerWidth < 768) {
  //////////////////////////
  // HANDLING MOBILE ONLY //
  //////////////////////////

  let documentBody = document.getElementsByTagName("body")[0];

  // MENU //

  let burger = document.getElementsByClassName("navbar_toggle")[0];
  let mobileMenu = document.getElementsByClassName("nav_categories")[0];
  let exitMobileMenu = document.getElementsByClassName(
    "nav_exit_mobile_menu"
  )[0];

  burger.addEventListener("click", () => {
    mobileMenu.classList.add("toggled_menu");

    animateCSS(mobileMenu, "slideInLeft");

    documentBody.classList.add("notScrollable");

    let dim = document.createElement("div");
    dim.classList.add("dim");
    document.getElementsByClassName("container")[0].appendChild(dim);
  });

  exitMobileMenu.addEventListener("click", () => {
    animateCSS(mobileMenu, "slideOutLeft");
    document.getElementsByClassName("dim")[0].remove();
    setTimeout(() => {
      mobileMenu.classList.remove("toggled_menu");
      documentBody.classList.remove("notScrollable");
    }, 950);
  });

  // PROFILE ICON //

  let profileIconSignIn = document.getElementsByClassName("profile-signin")[0]
    .firstElementChild;
  let loginMenu = document.getElementsByClassName("nav_login")[0];
  let exitMobileLogin = document.getElementsByClassName("nav_exit_login")[0];

  profileIconSignIn.addEventListener("click", () => {
    loginMenu.classList.add("toggled_login");

    animateCSS(loginMenu, "slideInDown");

    documentBody.classList.add("notScrollable");

    let dim = document.createElement("div");
    dim.classList.add("dim");
    document.getElementsByClassName("container")[0].appendChild(dim);
  });

  exitMobileLogin.addEventListener("click", () => {
    animateCSS(loginMenu, "slideOutUp");
    document.getElementsByClassName("dim")[0].remove();
    setTimeout(() => {
      loginMenu.classList.remove("toggled_login");
      documentBody.classList.remove("notScrollable");
    }, 950);
  });

  let profileIconSignedIn = document.getElementsByClassName(
    "profile-signed"
  )[0];
  profileIconSignedIn.addEventListener("click", () => {
    location.href = "./konto.html";
  });
} else {
  ///////////////////////////
  // HANDLING DESKTOP ONLY //
  ///////////////////////////

  // PROFILE ICON //

  if (document.getElementsByClassName("profile-signed").length > 0) {
    let profileIconSignedIn = document.getElementsByClassName(
      "profile-signed"
    )[0];

    profileIconSignedIn.addEventListener("click", () => {
      location.href = "./konto.html";
    });
  } else if (document.getElementsByClassName("profile-signin").length > 0) {
    let profileIconSignIn = document.getElementsByClassName(
      "profile-signin"
    )[0];

    profileIconSignIn.addEventListener("click", () => {
      location.href = "./logowanie.html";
    });
  }
}
