/*Script pentru validarea formularului de inregistrare*/

$("form").submit(function (e) { 
    
    let passwordField = document.getElementsByName("password");//returneaza un array cu obiecte care au numele password
    let password = passwordField[0].value; //valoarea din campul parolei 

    let repeatPassword = passwordField[1].value; //valoarea din campul parolei repetate
    let username = document.getElementsByName("username")[0].value; //valoarea introdusa in campul username

    let passwordPattern = new RegExp("^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z]).{8,32}$");//minim 8 caractere
    console.log(passwordPattern.test(password));

    if (!passwordPattern.test(password)){ //daca parola introdusa respecta pattern-ul
        document.getElementById("log").textContent = "Parola trebuie sa aiba minim 8 caractere, o litera mare, o litera mica si o cifra";
        e.preventDefault();//oprim formul din submitat
    }

    if (username.length === 0){//daca nu a fost scris un username
        document.getElementById("log").textContent = "Trebuie introdus un username";
        e.preventDefault();//oprim formul din submitat
    }

    if (password !== repeatPassword) {//daca nu corespund parolele 
        console.log("password : " + password + " repeated pass : " + repeatPassword);
        document.getElementById("log").innerText = "Parolele nu corespund";
        e.preventDefault();   
    }

});