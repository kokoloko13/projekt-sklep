let registerForm = document.getElementsByClassName("login_page_register")[0].children[0];
let registerPass = registerForm.children[2].children[1];
let registerPassAgain = registerForm.children[3].children[1];
let registerPassAgainParent = registerForm.children[3];
let registerFormSubmitBtn = registerForm.children[5];

function compareInputs(){
    if(registerPass.value !== registerPassAgain.value){
        registerPassAgain.style.borderColor = "red";
        if(registerForm.children[3].children[2] == null){
            let info = document.createElement("p");
            info.style.color = "red";
            info.innerHTML = "Hasła się różnią!";
            registerPassAgainParent.append(info);
            return false;
        }
    }else{
        registerPassAgain.style.borderColor = "black";
        if(registerForm.children[3].children[2] != null){
            registerForm.children[3].children[2].remove();
        }
        return true;
    }
}

registerPass.addEventListener("input", compareInputs);

registerPassAgain.addEventListener("input", compareInputs);
