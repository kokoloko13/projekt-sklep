////////////////////////////////////////// SHIPS //////////////////////////////////////////////////

let container = document.getElementsByClassName("container")[0];
let addShipButton = document.querySelector(".addShip > p");
let editIcon = document.getElementsByClassName("edit_Flag");
let removeIcon = document.getElementsByClassName("remove_Flag");

for (let i = 0; i < editIcon.length; i++) {
  editIcon[i].addEventListener("click", (event) => {
    let editModal = document.getElementById("editModal");
    let editForm = editModal.children[1].children[0];
    let shipID = event.target.parentElement.parentElement.children[0];
    let shipName = event.target.parentElement.parentElement.children[1];
    let shipShort = event.target.parentElement.parentElement.children[2];
    let shipPrice = event.target.parentElement.parentElement.children[3];
    let editModalInputs =
      editModal.children[1].children[0].children[0].children;
    let editCommitButton =
      editModal.children[1].children[0].children[1].children[1];
    let editCancelButton =
      editModal.children[1].children[0].children[1].children[0];
    let dim = document.createElement("div");
    dim.classList.add("dim");

    editModalInputs[0].value = shipID.innerHTML;
    editModalInputs[1].value = shipName.innerHTML;
    editModalInputs[2].value = shipShort.innerHTML;
    editModalInputs[3].value = shipPrice.innerHTML;

    container.appendChild(dim);
    editModal.classList.add("modalActive");

    editCancelButton.addEventListener("click", () => {
      editForm.reset();
      editModal.classList.remove("modalActive");
      document.getElementsByClassName("dim")[0].remove();
    });
  });
}

for (let i = 0; i < removeIcon.length; i++) {
  removeIcon[i].addEventListener("click", (event) => {
    let removeModal = document.getElementById("removeModal");
    let removeModalShipNameSpan =
      removeModal.children[0].children[0].children[1];
    let removeModalCancelButton = removeModal.children[1].children[0];
    let removeModalYesButton = removeModal.children[1].children[1];

    let shipID = event.target.parentElement.parentElement.children[0];
    let shipName = event.target.parentElement.parentElement.children[1];
    let dim = document.createElement("div");
    dim.classList.add("dim");

    removeModalShipNameSpan.innerHTML = shipName.innerHTML;

    container.appendChild(dim);
    removeModal.classList.add("modalActive");

    removeModalCancelButton.addEventListener("click", () => {
      document.getElementsByClassName("dim")[0].remove();
      removeModal.classList.remove("modalActive");
    });
  });
}

addShipButton.addEventListener("click", () => {
  let addShipModal = document.getElementById("addShipModal");
  let addShipForm = addShipModal.children[1].children[0];
  let addShipCancelButton =
    addShipModal.children[1].children[0].children[1].children[0];
  let addShipSubmitButton =
    addShipModal.children[1].children[0].children[1].children[1];
  let dim = document.createElement("div");
  dim.classList.add("dim");

  container.appendChild(dim);
  addShipModal.classList.add("modalActive");

  addShipCancelButton.addEventListener("click", () => {
    addShipForm.reset();
    document.getElementsByClassName("dim")[0].remove();
    addShipModal.classList.remove("modalActive");
  });
});

/////////////////////////////////////// END of SHIPS //////////////////////////////////////////////
