function validateName() {
    let userName = document.getElementById("nameId").value;
    let nameError = document.getElementById("nameError");
    let pattern = /^[A-Za-z ]+$/;

    if (userName.length < 3 || userName.length > 10 || !pattern.test(userName)) {
        nameError.innerText = "Name length between 3 and 10 and name should not contain numbers";
    } else {
        nameError.innerText = "";
    }
}

function validateEmail() {
    let userEmail = document.getElementById("emailId").value;
    let emailError = document.getElementById("emailError");
    let emailPattern = /^[A-Za-z0-9]+@gmail\.com$/;

    if (!emailPattern.test(userEmail)) {
        emailError.innerText = "Email should be in this pattern [A-Za-z0-9]@gmail.com";
    } else {
        emailError.innerText = "";
    }
}

function checkEmail() {
    let userEmail = document.getElementById("emailId").value;
    let emailError = document.getElementById("emailError");

    const xhttp = new XMLHttpRequest();
    xhttp.open("GET", "http://localhost:8080/XworkzModule/checkEmail/" + userEmail);
    xhttp.send();

    xhttp.onload = function () {
        emailError.innerHTML = this.responseText;
    }
}

function validatePhoneNumber() {
    let userPhone = document.getElementById("phoneNumber").value;
    let phoneError = document.getElementById("phoneError");
    let phonePattern = /^[6-9]\d{9}$/;

    if (!phonePattern.test(userPhone)) {
        phoneError.innerText = "Phone number must start with 6-9 and be 10 digits";
    } else {
        phoneError.innerText = "";
    }
}

function validateAge() {
    let userAge = document.getElementById("age").value;
    let ageError = document.getElementById("ageError");

    if (userAge < 15 || userAge > 50) {
        ageError.innerText = "Age Should be 15-50";
    } else {
        ageError.innerText = "";
    }
}

function validateGender() {
    let userGender = document.getElementById("genderId").value;
    let genderError = document.getElementById("genderError");

    if (userGender === "") {
        genderError.innerText = "Please select Gender";
        return false;
    } else {
        genderError.innerText = "";
        return true;
    }
}

function validatePassword() {
    let userPassword = document.getElementById("password").value;
    let passwordError = document.getElementById("passwordError");
    let passwordPattern = /^(?=.*[A-Z])(?=.*[^A-Za-z0-9])(?=(?:.*\d){2,}).{8,15}$/;


    if (!passwordPattern.test(userPassword)) {
        passwordError.innerText = "Must have 1 special char, 2 numbers, 1 capital letter, and length 8-15";
    } else {
        passwordError.innerText = "";
        checkPassword();
    }
}

function checkPassword() {
    let userPassword = document.getElementById("password").value;
    let passwordError = document.getElementById("passwordError");

    const xhttp = new XMLHttpRequest();
    xhttp.open("GET", "http://localhost:8080/XworkzModule/checkPassword/" + userPassword);
    xhttp.send();

    xhttp.onload = function () {
        passwordError.innerHTML = this.responseText;
    }
}

function viewPassword() {
    let password = document.getElementById("password");
    let icon = document.getElementById("toggleIcon");
    if (password.type === "password") {
        password.type = "text";
        icon.classList.remove("bi-eye");
        icon.classList.add("bi-eye-slash");
    } else {
        password.type = "password";
        icon.classList.remove("bi-eye-slash");
        icon.classList.add("bi-eye");
    }
}

function validateConfirmPassword() {
    let userPassword = document.getElementById("password").value;
    let confirmPassword = document.getElementById("confirmPassword").value;
    let confPasswordError = document.getElementById("confirmError");

    if (userPassword !== confirmPassword) {
        confPasswordError.innerText = "Password doesn't match";
    } else {
        confPasswordError.innerText = "";
    }
}
