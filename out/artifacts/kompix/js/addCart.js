let addIcons = document.getElementsByClassName("fa-cart-plus");

function localStorageTest() {
  const test = "test" + new Date().valueOf();
  try {
    localStorage.setItem(test, test);
    localStorage.removeItem(test);
    return true;
  } catch (e) {
    return false;
  }
}

if (localStorageTest()) {
  //localStorage.setItem("myElement", JSON.stringify(ob));

  for (addIcon of addIcons) {
    addIcon.addEventListener("click", (event) => {
      let product_name =
        event.target.parentElement.parentElement.previousElementSibling
          .children[0];
      let product_price =
        event.target.parentElement.parentElement.children[0].children[0];
      let product_href =
        event.target.parentElement.parentElement.previousElementSibling
          .children[0].href;

      let qty = 1;
      let singlePriceValue = Number(product_price.innerText);
      let finalPriceValue = Number(qty * singlePriceValue);
      let product_id = String(localStorage.length);

      let product = {
        id: "koszyk_" + product_id,
        href: product_href,
        name: product_name.innerText,
        qty: qty,
        singlePrice: singlePriceValue,
        finalPrice: finalPriceValue,
      };

      localStorage.setItem("koszyk_" + product_id, JSON.stringify(product));
      AddToCartNotification(product.name);
      setCartBadge();
    });
  }
}
