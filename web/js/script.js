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

} else {
  ///////////////////////////
  // HANDLING DESKTOP ONLY //
  ///////////////////////////


}
