$(document).ready(function() {


var setupMarkersInfo = function(offer) {

  var prop = offer.properties;

  var popup = '<h3>' + prop.address + '</h3>';

  offer.setIcon(L.icon({
     iconUrl: 'http://www.eoc.org.hk/eoc/otherproject/eng/color/youthcorner/programmes/careerchallenge2010/image/annaWu.jpg',
     iconSize: [35, 35],
     iconAnchor: [17, 31],
     popupAnchor: [0, -34]
   }));

}



  L.mapbox.accessToken = 'pk.eyJ1IjoibGlvcnJtIiwiYSI6InkzM2lOT2sifQ.rKc_Jo2tLLU7vy23ltzAuA';

  var southWest = L.latLng(-90, -420),
     northEast = L.latLng(90, 235),
     bounds = L.latLngBounds(southWest, northEast);

  var map = L.mapbox.map('map', 'liorrm.l5fek6l3', {zoomControl: false,
   maxZoom: 19,
   minZoom: 2,
   worldCopyJump: true
  });

  map.setView;

  var locations = L.mapbox.featureLayer().addTo(map);
  console.log(locations)

  locations.setGeoJSON(geoJSON);
  locations.eachLayer(setupMarkersInfo);

});
