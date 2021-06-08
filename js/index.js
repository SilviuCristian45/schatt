let navbar = document.querySelector('nav');//navbar where we store the elements 
let row1 = document.getElementById('row1');//first row in my website
let sections = document.getElementById('chatsections');

let button_state = false;//check if the button is displayed 
let button = CreateCustomButton('img/button.svg','60px','60px','12px',row1);
let navbarMobile = CreateMobileNavbar();

window.onresize = ManageNavBarButton;//manage-uim butonul si navbarmobile-ul si la resize (pt debug)
window.onload = ManageNavBarButton;//manage-uim butonul si navbarmobile-ul si la loading-ul paginii

function ManageNavBarButton() {
    if (screen.width < 870 && button.style.display == 'none'){
        console.log('lasam buton sa se vada');
        navbar.style.display = 'none';
        button.style.display = '';
    }
    if (screen.width > 870 && button.style.display == ''){
        console.log('ascundem buton si navbarMobile daca e deschis');
        button.style.display = 'none';
        navbar.style.display = '';//afisam navbarul
        if (navbarMobile.style.display == '')//daca navbarMobile a ramas pornit
            navbarMobile.style.display = 'none';
    }
}

function CreateCustomButton(bgimage, width, height, marginTop, parent) {
    let button = document.createElement("button");
    button.style.backgroundImage = `url(${bgimage})`;
    button.style.backgroundRepeat = 'no-repeat';
    button.style.width = width;
    button.style.height = height;
    button.style.marginTop = marginTop;
    button.style.display = 'none';
    button.onclick = DisplayNavbarMobile;
    parent.appendChild(button);
    return button;
}

function CreateMobileNavbar() {
    //adaugam la sectiuni ( ca sa le afisam pe verticala o singura coloana )
    //facem o copie inainte ca sa ramana si sus navbar-ul dar sa nu fie afisat
    let navbarMobile = document.createElement('nav');
    navbarMobile = navbar.cloneNode(true);
    sections.insertBefore(navbarMobile,sections.firstChild);
    //lista in sine trebuie sa afiseze pe coloana , deci cumva flex-direction - column 
    navbarMobile.querySelector('ul').style.flexDirection = 'column';
    navbarMobile.querySelector('ul').style.textAlign = 'left';
    navbarMobile.querySelector('ul').style.backgroundColor = 'grey';
    navbarMobile.style.display = 'none';
    return navbarMobile;
}

function DisplayNavbarMobile() {
    if (navbarMobile.style.display == 'none')
        navbarMobile.style.display = '';
    else navbarMobile.style.display = 'none';
}

//tranzitii cu jquery intre pagini 
$("a").click(function(e){
    e.preventDefault();//oprim comportamentul default la click-ul pe link
    let link =  $(this).attr('href');
    console.log(link);
    $("body").fadeOut("fast" , function() {//facem tot body-ul invisible
        console.log("fade out complete");//pe urma trecem la link 
        window.location = link;
    });  
});

//cand se incarca orice pagina avem un fade in pe body 
$(document).ready(function () {
    $("body").fadeIn("fast");
});

//cand se da click pe butonul pentru crearea unei conversatii
$("#createdm").click(function(){
    window.location = "createconversation.php";
});