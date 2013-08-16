

$(document).ready(function () 
{
  $('#file').change(function() 
 {
   $("#uploadExcelFileTextBox").val($('#file').val().substring(12));
     if ($("#uploadExcelFileTextBox").val().length > 0)
     {   
     }
 });
 $("#uploadExcelFileButton").click(function() 
 {
   $("#loading_image_on_wait_gif").css('z-index', 9999);
   $('#loading_image_on_wait_gif').show(); // show animation
   $("#entirePageDiv").fadeTo(500, 0.7)  
   return true; // allow regular form submission
 });

  $("input[type=file]").change(function()
  {
   $("#uploadExcelFileButton").removeAttr("disabled");
 });

  $("#updateRepoButton").click(function(event)
  {
     if (($("#updateSvnRepoAndDBTextField").val()) == '') {
         alert("Please Insert a Directory Name");
         event.preventDefault();
     }
     else {
        $("#loading_image_on_wait_gif").css('z-index', 9999);
        $('#loading_image_on_wait_gif').show(); // show animation
        $("#entirePageDiv").fadeTo(500, 0.7) 

     }
  });

  $("#jiraButton").click(function(event)
  {
     if (($("#usernameTag").val()) == '' || ($("#passwordTag").val()) == '' || ($("#PMOMTag").val()) == ''   ) {
         alert("Username, Password, and PMOM ticket key must be set before creating tickets");
         event.preventDefault();
     }
     else {
        $('#loading_image_on_wait_gif').css('zIndex', 9999); 
        $('#loading_image_on_wait_gif').show(); // show animation
        $("#entirePageDiv").fadeTo(500, 0.7) 
        
        
   
         return true; // allow regular form submission
     }
  });
});

function setBlank(me) {
 document.getElementById("updateSvnRepoAndDBTextField_hatch_hatch").value = ""
}
