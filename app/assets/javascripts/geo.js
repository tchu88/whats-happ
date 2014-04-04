$(function (){
  if (_.isEmpty($('#subscription_map'))) return;

  var circleStyle = {
    stroke:      true,
    color:       '#333',
    weight:      3,
    opacity:     1,
    fill:        true,
    fillColor:   '#333',
    fillOpacity: 0.5,
    dashArray:   [2, 6],
    lineCap:     'round',
    clickable:   false
  };
  var initialCoords = [37.7756648, -122.4136613];
  var nullCoords = { lat: null, lon: null };
  var map = L.map('subscription_map').setView(initialCoords, 12);
  var circle = L.circle(initialCoords, 0, circleStyle).addTo(map);
  L.tileLayer('http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png').addTo(map);

  function isBlank(str) { return (!str || /^\s*$/.test(str)); }
  function getLat(){ return parseFloat($('#subscription_latitude').val()); }
  function getLon(){ return parseFloat($('#subscription_longitude').val()); }
  function getRadius() { return parseInt($('#subscription_radius').val(), 10); }

  function drawRadius(coords) {
    coords.lat = coords.lat || getLat();
    coords.lon = coords.lon || getLon();
    coords.radius = getRadius();

    if (coords.radius && coords.lat && coords.lon) {
      circle.setLatLng([coords.lat, coords.lon]);
      circle.setRadius(coords.radius);
      map.fitBounds(circle.getBounds());
    }

    return coords;
  }
  function setLatLon(coords) {
    $('#subscription_longitude').val(coords.lon);
    $('#subscription_latitude').val(coords.lat);
    return coords;
  }
  function centerMap(coords){
    if (coords.lat && coords.lon) map.setView(new L.LatLng(coords.lat, coords.lon));
    return coords;
  }
  function geocodeURL(address){
    return "http://nominatim.openstreetmap.org/search?q="+
           encodeURIComponent(address)+
           "&format=json&limit=1&addressdetails=1";
  }
  function updateLocation() {
    var address = $(this).val();
    if (isBlank(address)) return setLatLon(nullCoords);
    $.getJSON(geocodeURL(address), _.compose(drawRadius, centerMap, setLatLon, _.first));
  }

  $('#subscription_radius').change(_.partial(drawRadius, nullCoords));
  $('#subscription_address').change(updateLocation);
});
