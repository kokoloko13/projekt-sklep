function animateCSS(element, animationName, callback) {
  const el = element;
  el.classList.add("animated", animationName);

  function handleAnimationEnd() {
    el.classList.remove("animated", animationName);
    el.removeEventListener("animationend", handleAnimationEnd);

    if (typeof callback === "function") callback();
  }

  el.addEventListener("animationend", handleAnimationEnd);
}
