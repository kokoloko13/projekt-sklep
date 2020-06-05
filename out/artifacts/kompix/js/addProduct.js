let fileContainer = document.getElementsByClassName("fileContainer")[0];
let fileInput = document.querySelectorAll(".fileContainer > input")[0];


  fileContainer.addEventListener("click", (event) => {
    let fileInput = event.target.children[0];
    fileInput.click();
  });


  fileInput.addEventListener("change", (event) => {
    const file = event.target.files[0];
    let plusIcon = event.target.nextElementSibling;
    let parent = event.target.parentElement;
    let parentLength = parent.children.length;
    let imgPreview = "";
    let uploadMessage = "";
    if (parentLength > 3) {
      imgPreview =
        event.target.nextElementSibling.nextElementSibling.nextElementSibling;
      uploadMessage = event.target.nextElementSibling.nextElementSibling;
    } else {
      imgPreview = event.target.nextElementSibling.nextElementSibling;
    }

    if (file) {
      const reader = new FileReader();

      if (uploadMessage !== "") {
        uploadMessage.style.display = "none";
      }
      plusIcon.style.display = "none";
      imgPreview.style.display = "initial";

      reader.addEventListener("load", function () {
        imgPreview.setAttribute("src", this.result);
      });

      reader.readAsDataURL(file);
    }
  });

