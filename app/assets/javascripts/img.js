$(document).ready(function(){
  $('input[name="restaurant[picture]"]').keyup(function(){
    var picture_src = $(this).val();
    $("#restaurant_picture_img").attr('src', picture_src);
  });
});