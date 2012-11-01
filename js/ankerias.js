$(document).ready(function(){
  $.get('switch/state', function(data) {
    $("#state").removeClass();
    if (data == "ON") {
      $("#state").addClass("on");
      $("#state").html("p&auml;&auml;ll&auml;");
    } else {
      $("#state").addClass("off");
      $("#state").html("pois");
    }
  });
  $("#button").click(function() {
    if ($("#state").hasClass("on")) {
      $.get('switch/off', function(date) {
        $("#state").removeClass();
        $("#state").addClass("off");
        $("#state").html("pois");
      });
    } else {
      $.get('switch/on', function(data) {
        $("#state").removeClass();
        $("#state").addClass("on");
        $("#state").html("p&auml;&auml;ll&auml;");
      });
    }
  });
});