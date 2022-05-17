$(function() {
  $('#close-flashes').on("click", 
    function () {
      flashes = document.getElementsByClassName('sportify-flash');

      for (flash of flashes) {
        flash.remove();
      }

      $('#close-flashes').remove();
    }
  );
});
