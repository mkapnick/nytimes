

 $(document).ready(function () 
 {
  $('#file').change(function() 
  {
    $("#textBox").val($('#file').val().substring(12));
      if ($("#textBox").val().length > 0)
      {   
      }
  });

  $("#chooseFileButton").click(function() 
  {
    $('#loading_image').show(); // show animation
    $("#entirePageDiv").fadeTo(500, 0.7)  
    return true; // allow regular form submission
  });

  $("#jiraButton").click(function() 
  {
    $('#loading_image').show(); // show animation
    $("#entirePageDiv").fadeTo(500, 0.7)  
    return true; // allow regular form submission
  });

   $("input[type=file]").change(function()
   {
    $("#chooseFileButton").removeAttr("disabled");
  });

   $("#updateRepoButton").click(function(event)
   {
      if (($("#textBox2").val()) == '') {
          alert("Please Insert a Directory Name");
          event.preventDefault();
      }
   });

   $("#jiraButton").click(function(event)
   {
      if (($("#usernameTag").val()) == '' || ($("#passwordTag").val()) == '' ) {
          alert("Username and Password must be set before creating tickets");
          event.preventDefault();
      }
   });
 });

 function setBlank(me) {
  document.getElementById("textBox2_hatch_hatch").value = ""
 }
