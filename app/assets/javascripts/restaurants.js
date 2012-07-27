$('.badge-success, .badge-important, .badge-info').popover({
	animation : true
});

$('ul.nav.nav-tabs li.totab a').click(function (e) {
  e.preventDefault();
  $(this).tab('show');
});

window.setInterval(modify_uplink, 500)
function modify_uplink(){
  var days = $('input.span1.up').val();
  var restaurant_id = $('input.span1').attr('id');
  var original = restaurant_id+"/upvote/";
  days.empty ? $("#other-"+restaurant_id+" a").attr('href', original+"0"); : $("#other-"+restaurant_id+" a").attr('href', original+days);
}

window.setInterval(modify_downlink, 500)
function modify_downlink(){
  var days = $('input.span1.up').val();
  var restaurant_id = $('input.span1.down').attr('id');
  var original = restaurant_id+"/downvote/";
  days.empty ? $("#other-"+restaurant_id+" a").attr('href', original+"0"); : $("#other-"+restaurant_id+" a").attr('href', original+days);
}