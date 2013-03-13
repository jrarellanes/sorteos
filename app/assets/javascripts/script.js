function cambiarText(texto){
  $("#container").shuffleLetters({text:texto});
}

$(document).ready(function(){  
	$("#container").shuffleLetters();
  $('#userText').click(function(){
    $.ajax({
      url:"premiar.json", 
      type:"GET",
      success: function(data){
        cambiarText(data);
      },
      error: function(data){
        cambiarText(data.responseText);
      }
    });
  });
});




