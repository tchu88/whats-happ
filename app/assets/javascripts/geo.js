$(function (){
  if (!$('body').hasClass('subscriptions-new')) return;

  var initialCoords = [37.7756648, -122.4136613];
  var map = L.map('subscription_map').setView(initialCoords, 12);
  L.tileLayer('http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png').addTo(map);

  function isBlank(str) {
    return (!str || /^\s*$/.test(str));
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
    if (isBlank(address)) return setLatLon({lat: null, lon: null});
    $.getJSON(geocodeURL(address), _.compose(setLatLon, centerMap, _.first));
  }

  $('#subscription_address').change(updateLocation);
});
