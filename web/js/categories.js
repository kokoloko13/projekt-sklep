/////////////////////////////////////// CATEGORIES /////////////////////////////////////////

let container = document.getElementsByClassName("container")[0];
let addCategoryButton = document.querySelector(".addCategory > p");
let editIcon = document.getElementsByClassName("edit_Flag");
let removeIcon = document.getElementsByClassName("remove_Flag");

for (let i = 0; i < editIcon.length; i++) {
  editIcon[i].addEventListener("click", (event) => {
    let editModal = document.getElementById("editModal");
    let editForm = editModal.children[1].children[0];
    let categoryID = event.target.parentElement.parentElement.children[0];
    let categoryName = event.target.parentElement.parentElement.children[1];
    let categoryIcon = event.target.parentElement.parentElement.children[2];
    let editModalInputs =
      editModal.children[1].children[0].children[0].children;
    let editCommitButton =
      editModal.children[1].children[0].children[1].children[1];
    let editCancelButton =
      editModal.children[1].children[0].children[1].children[0];
    let dim = document.createElement("div");
    dim.classList.add("dim");

    editModalInputs[0].value = categoryID.innerHTML;
    editModalInputs[1].value = categoryName.innerHTML;
    editModalInputs[2].value = categoryIcon.innerHTML;

    container.appendChild(dim);
    editModal.classList.add("modalActive");

    editCancelButton.addEventListener("click", () => {
      editForm.reset();
      editModal.classList.remove("modalActive");
      document.getElementsByClassName("dim")[0].remove();
    });

    editCommitButton.addEventListener("click", ()=>{
      editForm.submit();
      window.location.reload();
    });
  });
}

for (let i = 0; i < removeIcon.length; i++) {
  removeIcon[i].addEventListener("click", (event) => {
    let removeModal = document.getElementById("removeModal");
    let removeModalCategoryNameSpan =
      removeModal.children[0].children[0].children[1];
    let removeModalCancelButton = removeModal.children[1].children[0];
    let removeModalYesButton = removeModal.children[1].children[1];

    let categoryID = event.target.parentElement.parentElement.children[0];
    let categoryName = event.target.parentElement.parentElement.children[1];
    let dim = document.createElement("div");
    dim.classList.add("dim");

    removeModalCategoryNameSpan.innerHTML = categoryName.innerHTML;

    container.appendChild(dim);
    removeModal.classList.add("modalActive");

    removeModalCancelButton.addEventListener("click", () => {
      document.getElementsByClassName("dim")[0].remove();
      removeModal.classList.remove("modalActive");
    });

  removeModalYesButton.addEventListener("click", () => {
    const Http = new XMLHttpRequest();
  const url = '/DeleteCategory?id=' + categoryID.innerHTML;
  Http.open("GET", url);
  Http.send();
  window.location.reload();
});

  });
}

addCategoryButton.addEventListener("click", () => {
  let addCategoryModal = document.getElementById("addCategoryModal");
  let addCategoryForm = addCategoryModal.children[1].children[0];
  let addCategoryCancelButton =
    addCategoryModal.children[1].children[0].children[1].children[0];
  let addCategorySubmitButton =
    addCategoryModal.children[1].children[0].children[1].children[1];
  let dim = document.createElement("div");
  dim.classList.add("dim");

  container.appendChild(dim);
  addCategoryModal.classList.add("modalActive");

  addCategoryCancelButton.addEventListener("click", () => {
    addCategoryForm.reset();
    document.getElementsByClassName("dim")[0].remove();
    addCategoryModal.classList.remove("modalActive");
  });

  addCategorySubmitButton.addEventListener("click", ()=>{
    addCategoryForm.submit();
    window.location.reload();
  });
});

/////////////////////////////////////// END of CATEGORIES /////////////////////////////////////////
