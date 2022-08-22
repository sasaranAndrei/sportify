
const CLUJ_NAPOCA_MAP_CENTER_LATITUDE = 46.75550;
const CLUJ_NAPOCA_MAP_CENTER_LONGITUDE = 23.59950;

const BAIA_MARE_MAP_CENTER_LATITUDE = 47.65321;
const BAIA_MARE_MAP_CENTER_LONGITUDE = 23.56061;

var selectedArenaTitle = -1; // no arena selected yet

$(document).on('turbolinks:load', function () {
  url = window.location.href;
  arenas_path = '/arenas';
  url_substring_path = url.substring(url.length - arenas_path.length);

  if (url_substring_path == arenas_path) {
    initGoogleMaps();
  }
});

function initGoogleMaps() {
  $.ajax({
    url: '/arenas',
    type: 'get',
    data: '',
    dataType: 'json',
    success: function(data) { drawMap(data) },
    error: function() { console.log('Error GET Arenas'); },
  });
}

function extractLocationsFromArenas(arenas) {
  locations = [];

  for (arena of arenas) {
    arenaData = [arena.title, arena.latitude, arena.longitude, arena.id];
    locations.push(arenaData);
  }

  return locations;
}

function drawMap(arenas) {
  var locations = extractLocationsFromArenas(arenas);
  
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: new google.maps.LatLng(BAIA_MARE_MAP_CENTER_LATITUDE, BAIA_MARE_MAP_CENTER_LONGITUDE),
    mapTypeId: google.maps.MapTypeId.ROADMAP
  });
  
  var infowindow = new google.maps.InfoWindow();
  
  var marker, i;
  
  for (i = 0; i < locations.length; i++) {  
    marker = new google.maps.Marker({
      position: new google.maps.LatLng(locations[i][1], locations[i][2]),
      map: map
    });
    
    google.maps.event.addListener(marker, 'click', (function(marker, i) {
      return function() {
        infowindow.setContent(locations[i][0]);
        infowindow.open(map, marker);
        selectedArenaTitle = locations[i][3];
        
        noticeReservationButton(selectedArenaTitle);
      }
    })(marker, i));
  }
}

function noticeReservationButton(selectedArenaTitle) {
  var createReservationButton = document.getElementById('arenas-create-reservation-button');
  shakeElement(createReservationButton);
  
  let arenaHiddenField = document.getElementById('arena_id');
  arenaHiddenField.value = selectedArenaTitle;
}

function shakeElement(element) {
  var interval = 100;
  var distance = 10;
  var times = 4;

  $(element).css('position', 'relative');

  for (var iter = 0; iter < (times + 1) ; iter++) {
      $(element).animate({
          left: ((iter % 2 == 0 ? distance : distance * -1))
      }, interval);
  }                                                                                                          
  $(element).animate({ left: 0 }, interval);
}
