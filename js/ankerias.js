$(document).ready(function(){
  $("#state").text(". . .");
  $.get('switch/state', function(data) {
    if (data == "ON") {
      $("#state").removeClass("off");
      $("#state").addClass("on");
      $("#state").html("ON");
    } else {
      $("#state").removeClass("on");
      $("#state").addClass("off");
      $("#state").html("OFF");
    }
  });
  $("#button_on").click(function() {
    $.get('switch/on', function(data) {
      $("#state").removeClass("off");
      $("#state").addClass("on");
      $("#state").html("ON");
    });
  });
  $("#button_off").click(function() {
    $.get('switch/off', function(data) {
      $("#state").removeClass("on");
      $("#state").addClass("off");
      $("#state").html("OFF");
    });
  });
});