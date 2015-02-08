var setupMarkersInfo = function(offer) {
  console.log("hey from setupMarkersInfo")

  var prop = offer.feature.properties;

  var popup = '<h3>Offer Price: $' + prop.price + '</h3>';

   popup += '<h4>Address: ' + prop.address + '</h4>';

   // popup += '<p>Bedrooms: ' + prop.bedrooms + '</p>';

  offer.bindPopup(popup);

  offer.on('click', function(e) {
    offer.openPopup();
  })

  offer.setIcon(L.icon({
     iconUrl: 'https://files.slack.com/files-pri/T03K5BHN8-F03K818AB/noun_1144.png',
     iconSize: [20, 20],
     iconAnchor: [10, 15],
     popupAnchor: [0, -34]
   }));

}

L.mapbox.accessToken = 'pk.eyJ1IjoibGlvcnJtIiwiYSI6InkzM2lOT2sifQ.rKc_Jo2tLLU7vy23ltzAuA';


var map = L.mapbox.map('map', 'liorrm.l5fek6l3', { zoomControl: false,
 maxZoom: 19,
 minZoom: 2,
 worldCopyJump: true
});

console.log("this is map!", map)

map.setView;

var locations = L.mapbox.featureLayer().addTo(map);
console.log("this is locations", locations)

locations.setGeoJSON(geoJSON);
locations.eachLayer(setupMarkersInfo);
