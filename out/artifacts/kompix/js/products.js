////////////////////////////////////////// PRODUCTS //////////////////////////////////////////////////

let container = document.getElementsByClassName("container")[0];
let addProductButton = document.querySelector(".addProduct > p");
let removeIcon = document.getElementsByClassName("remove_Flag");

for (let i = 0; i < removeIcon.length; i++) {
  removeIcon[i].addEventListener("click", (event) => {
    let removeModal = document.getElementById("removeModal");
    let removeModalProductNameSpan =
      removeModal.children[0].children[0].children[1];
    let removeModalCancelButton = removeModal.children[1].children[0];
    let removeModalYesButton = removeModal.children[1].children[1];

    let productID = event.target.parentElement.parentElement.children[0];
    let productName = event.target.parentElement.parentElement.children[1];
    let dim = document.createElement("div");
    dim.classList.add("dim");

    removeModalProductNameSpan.innerHTML = productName.innerHTML;

    container.appendChild(dim);
    removeModal.classList.add("modalActive");

    removeModalCancelButton.addEventListener("click", () => {
      document.getElementsByClassName("dim")[0].remove();
      removeModal.classList.remove("modalActive");
    });

    removeModalYesButton.addEventListener("click", () => {
      const Http = new XMLHttpRequest();
      const url = '/DeleteProduct?id=' + productID.innerHTML;
      Http.open("GET", url);
      Http.send();
      window.location.reload();
    });

  });
}

addProductButton.addEventListener("click", () => {
  let addProductModal = document.getElementById("addProductModal");
  let addProductForm = addProductModal.children[0].children[0];
  let addProductCancelButton =
    addProductModal.children[0].children[0].children[3].children[1];
  let addProductSubmitButton =
    addProductModal.children[0].children[0].children[3].children[0];
  let dim = document.createElement("div");
  dim.classList.add("dim");

  container.appendChild(dim);
  addProductModal.classList.add("modalActive");

  addProductCancelButton.addEventListener("click", () => {
    addProductForm.reset();
    document.getElementsByClassName("dim")[0].remove();
    addProductModal.classList.remove("modalActive");
  });

  addProductSubmitButton.addEventListener("click", () =>{
    addProductForm.submit();
    window.location.reload();
  });
});

/////////////////////////////////////// END of PRODUCTS //////////////////////////////////////////////
