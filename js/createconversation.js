//request la click pe butonul send prin care inseram mesajul in baza de date 
$("button").click(function(){
    console.log("pp");
    $.post("server/senddm.php",//exact ca metoda de mai sus dar cu jquery
        {
            message: $("textarea").val(),//punem mesajul scris in textarea 
            //incarcam data si ora la care a fost trimis 
            timestampp: new Date().toISOString().slice(0, 19).replace('T', ' '),
            new_user: $("input").val()
        }
    ,function (data) {
        $("#mesaj").text(data);
    });

    $("button").prop('disabled',true);//facem butonul disabled 
}); 