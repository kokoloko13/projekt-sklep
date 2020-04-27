if (window.innerWidth < 768) {
  // ORDER ACCORDION //

  let orders = document.getElementsByClassName(
    "account_content_orders_list_order"
  );

  function resetOrders() {
    for (let L = 0; L < orders.length; L++) {
      orders[L].classList.remove("active_order");
      for (let j = 0; j < orders[L].children.length; j++) {
        orders[L].children[j].classList.remove("active_element");
      }
    }
  }

  for (let k = 0; k < orders.length; k++) {
    orders[k].addEventListener("click", (event) => {
      if (event.currentTarget.classList.contains("active_order")) {
        resetOrders();
      } else {
        resetOrders();
        let children = event.currentTarget.children;
        event.currentTarget.classList.toggle("active_order");

        for (let i = 1; i < children.length; i++) {
          children[i].classList.toggle("active_element");
        }
      }
    });
  }
}

// KONTO MENU //
let acc = document.getElementsByClassName("account_content_personal_data")[0];
let chngPswd = document.getElementsByClassName(
  "account_content_password_change"
)[0];
let chngData = document.getElementsByClassName(
  "account_content_personal_data_change"
)[0];
let ordrs = document.getElementsByClassName("account_content_orders")[0];
let opts = document.getElementsByClassName("account_category_element");

function setHash() {
  switch (window.location.hash) {
    case "#konto": {
      for (let i = 0; i < opts.length; i++) opts[i].classList.remove("active");
      opts[0].classList.add("active");
      acc.style.display = "initial";
      chngPswd.style.display = "none";
      chngData.style.display = "none";
      ordrs.style.display = "none";
      break;
    }

    case "#zmiana-hasla": {
      for (let i = 0; i < opts.length; i++) opts[i].classList.remove("active");
      opts[3].classList.add("active");
      acc.style.display = "none";
      chngPswd.style.display = "initial";
      chngData.style.display = "none";
      ordrs.style.display = "none";
      break;
    }

    case "#zmiana-danych": {
      for (let i = 0; i < opts.length; i++) opts[i].classList.remove("active");
      opts[1].classList.add("active");
      acc.style.display = "none";
      chngPswd.style.display = "none";
      chngData.style.display = "initial";
      ordrs.style.display = "none";
      break;
    }

    case "#zamowienia": {
      for (let i = 0; i < opts.length; i++) opts[i].classList.remove("active");
      opts[2].classList.add("active");
      acc.style.display = "none";
      chngPswd.style.display = "none";
      chngData.style.display = "none";
      ordrs.style.display = "initial";
      break;
    }
  }
}

if (window.location.hash == "") {
  acc.style.display = "initial";
  chngPswd.style.display = "none";
  chngData.style.display = "none";
  ordrs.style.display = "none";
}

window.onhashchange = setHash;
