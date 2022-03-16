$(document).ready(function() {
  $('#book_option').on('change',function(){
    var quantity = $("#book_option").find(":selected").data("quantity")
    $('span#quantity_book').text(quantity);
  });
});
