let chatbox = document.getElementById("chatsection"); 

//Trimitem requestul intial pentru a scoate toate mesajele 
let xhttp = new XMLHttpRequest();
xhttp.onreadystatechange = function() {//la terminarea request-ului asignam functia aceasta
    if (this.readyState == 4 && this.status == 200) {//daca avem ok-ul de la server ca s-a primit request-ul
        $("#chatsection").prepend(this.response);
        //console.log(this.response);
    }
};
xhttp.open("GET", "server/messages.php", true);//deschidem request-ul 
xhttp.send();//trimitem request-ul la server

//repetam acest request la fiecare 5 secunde si luam asincron din baza de date mesajele si facem append
setInterval( () => {
    //let currentTime = new Date().toISOString().slice(0, 19).replace('T', ' ');
    //console.log(currentTime);
    let xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {//la terminarea request-ului asignam functia aceasta
        if (this.readyState == 4 && this.status == 200) {//daca avem ok-ul de la server ca s-a primit request-ul
            $("#chatsection").prepend(this.response);
        }
    };
    let lastMessageTimestampp;
    let timestamp;
    console.log($("#chatsection p:first-child"));
    //trebuie trimis timestampul ultimului mesaj din DOM
    if($("#chatsection p:first-child")){
        console.log("ultimul mesaj din DOM" + $("#chatsection p:first-child").text());
        lastMessageTimestampp = $("#chatsection p:first-child").text();
        //luam timestamp din string ce e intre paranteze
        let p1 = lastMessageTimestampp.indexOf('(');
        let p2 = lastMessageTimestampp.indexOf(')');
        timestamp = lastMessageTimestampp.substr(p1+1,p2-2);

        timestamp = timestamp.replace(')','');//stergem o ) daca ramane 
        console.log("cu timestamp : " + timestamp);
    }
    //console.log(lastMessageTimestampp); 
    if(timestamp){
        console.log(timestamp);
        xhttp.open("GET", "server/messages.php?currentTime="+timestamp, true);//deschidem request-ul 
        xhttp.send();//trimitem request-ul la server
    }
} , 5000)

//request la click pe butonul send prin care inseram mesajul in baza de date 
$("#sendGlobalChat").click(function(){
    console.log("mesaj trimis pe global chat");
    let dataToSend = new FormData(); //obiect care ma ajuta sa transmit datele 
    let imageData = $("#imagefile").prop('files')[0]; //stochez fisierul incarcat in inputul de tip file

    //completez formularul "imaginar"
    dataToSend.append('message', $("textarea").val() );
    dataToSend.append('timestampp', new Date().toISOString().slice(0, 19).replace('T', ' ') );
    console.log(new Date().toISOString().slice(0, 19).replace('T', ' '));
    dataToSend.append('fileToUpload', imageData);

    //trimitem request-ul 
    $.ajax({
        url: 'server/sendmessage.php', // point to server-side PHP script 
        cache: false,
        contentType: false,
        processData: false,
        data: dataToSend,                       
        type: 'post',
        statusCode: {//a mers asa , nu mergea cu succes 
            200: function (data) {
                //afisam userului o eroare in caz ca se intampla sa incarce altceva decat o poza
                document.getElementById("log").innerText = data;
                //golim textarea-ul pt a-i fie mai usor userului (sa nu mai stearga el vechiul mesaj)
                $("textarea").val("");
                //dam disable la button 
                document.querySelector('#sendGlobalChat').disabled = true;
                //console.log("trebuie dat disable la buton");
                //reactivam butonul doar dupa 3 secunde (ca sa prevenim spamul)
                setTimeout( () => {
                    document.querySelector('#sendGlobalChat').disabled = false;
                }, 3000); 
                //golim file inputul 
                $("#imagefile").val(""); 
            }
        }
     });

}); 
