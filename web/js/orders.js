////////////////////////////////////////// ORDERS //////////////////////////////////////////////////

let container = document.getElementsByClassName("container")[0];
let editIcon = document.getElementsByClassName("edit_Flag");

for (let i = 0; i < editIcon.length; i++) {
  editIcon[i].addEventListener("click", (event) => {
    let editModal = document.getElementById("editOrderModal");
    let editForm = editModal.children[0].children[0];

    let orderNum = event.target.parentElement.parentElement.children[1];
    let orderStatus = event.target.parentElement.parentElement.children[3];
    let orderVat = event.target.parentElement.parentElement.children[4];
    let orderShip = event.target.parentElement.parentElement.children[5];
    let orderTracking = event.target.parentElement.parentElement.children[6];

    let editModalInputs =
      editModal.children[0].children[0].children[0].children;
    let editCommitButton =
      editModal.children[0].children[0].children[1].children[1];
    let editCancelButton =
      editModal.children[0].children[0].children[1].children[0];
    let dim = document.createElement("div");
    dim.classList.add("dim");

    container.appendChild(dim);
    editModal.classList.add("modalActive");

    editCancelButton.addEventListener("click", () => {
      editForm.reset();
      editModal.classList.remove("modalActive");
      document.getElementsByClassName("dim")[0].remove();
    });
  });
}

/////////////////////////////////////// END of ORDERS //////////////////////////////////////////////
