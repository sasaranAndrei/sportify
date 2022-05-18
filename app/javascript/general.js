$(document).on('click', '#close-flashes', function() {
  flashes = document.getElementsByClassName('sportify-flash');

  for (flash of flashes) {
    flash.remove();
  }

  $('#close-flashes').remove();
});
