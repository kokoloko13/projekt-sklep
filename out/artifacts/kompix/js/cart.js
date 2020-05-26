let productsInCart = document.getElementsByClassName("cart_step_content_list_product");
let cartCounter = document.getElementById("cartCount");
let deliveryChoice = document.getElementById("delivery");
let cartList = document.getElementsByClassName("product_list")[0];
let trashIcons = document.getElementsByClassName("fa-trash-alt");
let minuses = document.getElementsByClassName("fa-minus-square");
let pluses = document.getElementsByClassName("fa-plus-square");
let checkoutButton = document.querySelector(".checkoutButton > p");

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

function fillCart() {
  if (localStorageTest()) {
    for (let i = 0; i < localStorage.length; i++) {
      if(localStorage.getItem("koszyk_"+i) !== null){
        let product = JSON.parse(localStorage.getItem("koszyk_" + i));

        let productNode = document.createElement("li");
        let productContainer = document.createElement("div");
        productContainer.classList.add("cart_step_content_list_product");
        productContainer.setAttribute("product-id", String(product.id));

        // ELEMENT WITH PRODUCT NAME //
        let productNameContainer = document.createElement("div");
        productNameContainer.classList.add(
            "cart_step_content_list_product_element"
        );
        let productNameParagraph = document.createElement("p");
        let productNameHref = document.createElement("a");
        productNameHref.setAttribute("href", product.href);
        let productName = document.createTextNode(product.name);

        productNameContainer.appendChild(productNameParagraph);
        productNameParagraph.appendChild(productNameHref);
        productNameHref.appendChild(productName);

        // ELEMENT WITH QUANTITY //
        let qtyContainer = document.createElement("div");
        qtyContainer.classList.add("cart_step_content_list_product_element");
        let arrowMinus = document.createElement("i");
        arrowMinus.setAttribute("class", "fas fa-minus-square");
        let qtyField = document.createElement("p");
        qtyField.classList.add("qty");
        let qtyValue = document.createTextNode(product.qty);
        let arrowPlus = document.createElement("i");
        arrowPlus.setAttribute("class", "fas fa-plus-square");

        qtyContainer.appendChild(arrowMinus);
        qtyContainer.insertBefore(qtyField, arrowMinus.nextSibling);
        qtyField.appendChild(qtyValue);
        qtyContainer.insertBefore(arrowPlus, qtyField.nextSibling);

        // ELEMENT WITH PRICE //
        let priceContainer = document.createElement("div");
        priceContainer.classList.add("cart_step_content_list_product_element");
        let pricePragraph = document.createElement("p");
        let costSpan = document.createElement("span");
        costSpan.classList.add("cost");
        costSpan.setAttribute("data-value", product.singlePrice);
        let currencySpan = document.createElement("span");
        currencySpan.classList.add("currency");
        let finalCost = document.createTextNode(product.finalPrice);
        let currencyText = document.createTextNode("PLN");

        priceContainer.appendChild(pricePragraph);
        pricePragraph.appendChild(costSpan);
        costSpan.appendChild(finalCost);
        pricePragraph.insertBefore(currencySpan, costSpan.nextSibling);
        currencySpan.appendChild(currencyText);

        // ELEMENT WITH TRASH //
        let trashContainer = document.createElement("div");
        trashContainer.classList.add("cart_step_content_list_product_trash");
        let trash = document.createElement("i");
        trash.setAttribute("class", "fas fa-trash-alt");

        trashContainer.appendChild(trash);

        productNode.appendChild(productContainer);
        productContainer.appendChild(productNameContainer);
        productContainer.insertBefore(
            qtyContainer,
            productNameContainer.nextSibling
        );
        productContainer.insertBefore(priceContainer, qtyContainer.nextSibling);
        productContainer.insertBefore(trashContainer, priceContainer.nextSibling);

        cartList.appendChild(productNode);
      }else{
        continue;
      }
    }
  }
}

function setCartCostValue() {
  let cartCost = document.getElementsByClassName(
    "cart_summary_cartCost_value"
  )[0];
  let sum = 0;

  for (product of productsInCart) {
    let productPrice = product.children[2].children[0].children[0];
    let productPriceValue = parseFloat(productPrice.innerText).toFixed(2);
    sum += Number(productPriceValue);
  }

  cartCost.innerHTML = parseFloat(sum).toFixed(2);
  return sum;
}

function setDeliveryCostValue() {
  let deliveryMethod = deliveryChoice.value;
  let deliverySummaryField = document.getElementsByClassName(
    "cart_summary_delivery_value"
  )[0];

  let deliveryCost = 0;

  switch (deliveryMethod) {
    case "DPD":
      deliveryCost = 15.0;
      break;
    case "DHL":
      deliveryCost = 15.0;
      break;
    case "inpost":
      deliveryCost = 10.0;
      break;
    default:
      deliveryCost = 15.0;
      break;
  }

  deliveryCost = Number(parseFloat(deliveryCost).toFixed(2));
  deliverySummaryField.innerHTML = deliveryCost;
  return deliveryCost;
}

function setCartCounter() {

  cartCounter.innerHTML = productsInCart.length;
}

function setFinalCartCost() {
  let finalPrice = document.getElementsByClassName(
    "cart_summary_cost_value"
  )[0];

  let deliveryCost = setDeliveryCostValue();
  let cartValue = setCartCostValue();
  let discount = 0;

  let sum = Number(deliveryCost + cartValue - discount);

  finalPrice.innerHTML = parseFloat(sum).toFixed(2);
}

function emptyAlertCart() {
  let paragraph = document.createElement("p");
  paragraph.style.paddingTop = "3rem";
  let paragraphText = document.createTextNode("Brak produktów w koszyku.");
  paragraph.appendChild(paragraphText);

  cartList.appendChild(paragraph);
}

if (localStorage.length === 0) {
  emptyAlertCart();
} else {
  fillCart();
}

setCartCounter();
setFinalCartCost();

deliveryChoice.addEventListener("change", () => {
  setFinalCartCost();
});

for (plus of pluses) {
  plus.addEventListener("click", (event) => {
    let qty = event.target.previousElementSibling;
    let qtyValue = parseInt(qty.innerText);
    let price =
      event.target.parentElement.nextElementSibling.children[0].children[0];
    let priceValue = parseFloat(price.dataset.value).toFixed(2);
    let productId = event.target.parentElement.parentElement.getAttribute("product-id");

    if (qtyValue < 9) {
      qtyValue++;
      qty.innerHTML = qtyValue;
      let product = JSON.parse(localStorage.getItem(productId));
      product.qty++;
      product.finalPrice = product.singlePrice * product.qty;
      localStorage.setItem(productId, JSON.stringify(product));
    } else {
      qtyValue = 9;
      qty.innerHTML = qtyValue;
    }

    price.innerHTML = parseFloat(qtyValue * priceValue).toFixed(2);
    setFinalCartCost();
    setCartBadge();
  });
}

for (minus of minuses) {
  minus.addEventListener("click", (event) => {
    let qty = event.target.nextElementSibling;
    let qtyValue = parseInt(qty.innerText);
    let price =
      event.target.parentElement.nextElementSibling.children[0].children[0];
    let priceValue = parseFloat(price.dataset.value).toFixed(2);
  let productId = event.target.parentElement.parentElement.getAttribute("product-id");

    if (qtyValue > 1) {
      qtyValue--;
      qty.innerHTML = qtyValue;
      let product = JSON.parse(localStorage.getItem(productId));
      product.qty--;
      product.finalPrice = product.singlePrice * product.qty;
      localStorage.setItem(productId, JSON.stringify(product));
    } else {
      qtyValue = 1;
      qty.innerHTML = qtyValue;
    }

    price.innerHTML = parseFloat(qtyValue * priceValue).toFixed(2);
    setFinalCartCost();
    setCartBadge();
  });
}

for (trashIcon of trashIcons) {
  trashIcon.addEventListener("click", (event) => {
    let trashParent = event.target.parentElement.parentElement;
    let productId = trashParent.getAttribute("product-id");
    let productInStorage = localStorage.getItem(productId);

    trashParent.remove();
    localStorage.removeItem(productId);
    setCartCounter();
    setFinalCartCost();
    setCartBadge();

    if (localStorage.length === 0) {
      emptyAlertCart();
    }
  });
}

checkoutButton.addEventListener("click", () => {
  let order = [];

  for(let i=0; i < localStorage.length; i++){

    if(localStorage.getItem("koszyk_"+i) !== null){
      order.push(localStorage.getItem("koszyk_"+i));
    }else{
      i++;
    }
  }

  let cookieName = 'user_email';
  let ship = document.getElementById("delivery").value;
  let total = document.getElementsByClassName("cart_summary_cost_value")[0].textContent;

  var match = document.cookie.match(new RegExp('(^| )' + cookieName + '=([^;]+)'));
  if (match) {
   cookieValue= match[2];
  }
  else{
    console.log('--something went wrong---');
  }

  console.log(total);

  $.ajax({
    url: '/Checkout',
    type: 'POST',
    dataType: 'application/json',
    data: {
      objarray: JSON.stringify(order),
      user_email: JSON.stringify(cookieValue),
      ship_method: JSON.stringify(ship),
      priceAmount: JSON.stringify(total)
    },
    success: function(result) {
      alert('SUCCESS');
    }
  });

localStorage.clear();

});