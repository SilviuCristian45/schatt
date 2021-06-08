/* In acest script ma ocup de trimiterea unui dm si update-ul casutei de dm corespunzatoare unui user*/

let userto = document.getElementById("ss").innerText;
console.log(userto);

$.get("../server/dm.php",{
    userto:userto,
    currentTime:"0"
},
function(data) {
    $("#chatsection").prepend(data);
}
); 

setInterval( () => {
    console.log(userto);

    //luam timestampul ultimului mesaj afisat in pagina
    let lastMessageTimestampp;
    let timestamp;
    //trebuie trimis timestampul ultimului mesaj din DOM
    if((document.getElementById("chatsection") ).innerHTML.indexOf("<p>") >= 0){
        console.log("ultimul mesaj din DOM" + $("#chatsection p:first-child").text());
        lastMessageTimestampp = $("#chatsection p:first-child").text();
        //luam timestamp din string ce e intre paranteze
        let p1 = lastMessageTimestampp.indexOf('(');
        let p2 = lastMessageTimestampp.indexOf(')');
        timestamp = lastMessageTimestampp.substr(p1+1,p2-2);

        timestamp = timestamp.replace(')','');//stergem o ) daca ramane 
        console.log("cu timestamp : " + timestamp);
    }

    $.get("../server/dm.php",{
            userto:userto,
            currentTime:timestamp
        },
        function(data) {
            $("#chatsection").prepend(data);
        }
    ); 
}, 5000);

$("#sendbtn").click(function () { 
    console.log("click click");

    let dataToSend = new FormData();
    let imageData = $("#imagefile").prop('files')[0];

    //completez formularul "imaginar"
    dataToSend.append('message', $("textarea").val() );
    dataToSend.append('timestampp', new Date().toISOString().slice(0, 19).replace('T', ' '));
    dataToSend.append('fileToUpload', imageData);
    dataToSend.append('new_user', userto);

    //trimitem request-ul 
    $.ajax({
        url: '../server/senddm.php', // point to server-side PHP script 
        cache: false,
        contentType: false,
        processData: false,
        data: dataToSend,                         
        type: 'post',
        statusCode: {
            200:function (data) {
                document.getElementById("log").innerText = data;
            console.log(data);
            $("textarea").val("");//golim textarea-ul
            document.querySelector("#sendbtn").disabled = true;//disable la buton pt 2 secunde ca sa nu se faca spam
            setTimeout( () => {
                document.querySelector("#sendbtn").disabled = false;//peste 2 sec. dam enable la buton
            }, 2000);
            }
        }
     });

});
