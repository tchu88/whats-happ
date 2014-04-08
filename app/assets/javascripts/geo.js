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
  var eventMarkers = new L.FeatureGroup();
  L.tileLayer('http://{s}.tile.stamen.com/toner/{z}/{x}/{y}.png').addTo(map);

  function isBlank(str) { return (!str || /^\s*$/.test(str)); }
  function defaultIfBlank(val, _default) { return isBlank(val) ? _default || "" : val; }
  function getLat(){ return defaultIfBlank(parseFloat($('#subscription_latitude').val())); }
  function getLon(){ return defaultIfBlank(parseFloat($('#subscription_longitude').val())); }
  function getRadius() { return defaultIfBlank(parseInt($('#subscription_radius').val(), 10)); }
  function fitBounds (e) { return map.fitBounds(circle.getBounds()); }

  function buildCoords(coords) {
    coords = _.pick(coords || {}, 'lat', 'lon', 'radius');
    coords.lat = coords.lat || getLat();
    coords.lon = coords.lon || getLon();
    coords.radius = coords.radius || getRadius();
    return coords;
  }
  function clearEventMarkers() {
    eventMarkers.eachLayer(function(layer){
      map.removeLayer(layer);
    });
  }
  function displayEventMarker(event) {
    var marker = L.marker([event.latitude, event.longitude]).addTo(map);
    marker.bindPopup('<p>'+event.message+'<br/><small>'+event.created_at+'</small></p>');
    eventMarkers.addLayer(marker);
    return marker;
  }
  function displayEvents(data) {
    _.each(data, displayEventMarker);
    return data;
  }
  function eventsInArea(coords) {
    coords = buildCoords(coords);
    clearEventMarkers();

    if (!coords.lat || !coords.lon || !coords.radius) return coords;

    $.getJSON('/events', {
      latitude: coords.lat,
      longitude: coords.lon,
      radius: coords.radius
    }).done(displayEvents);

    return coords;
  }
  function drawRadius(coords) {
    coords = buildCoords(_.extend(coords || {}, {radius: getRadius()}));

    if (coords.radius && coords.lat && coords.lon) {
      circle.setLatLng([coords.lat, coords.lon]);
      circle.setRadius(coords.radius);
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
    $.getJSON(geocodeURL(address), _.compose(eventsInArea, drawRadius, centerMap, setLatLon, _.first));
  }

  $('#subscription_address').change(updateLocation);
  $('#subscription_radius')
    .keyup(_.compose(_.throttle(eventsInArea, 500), _.partial(drawRadius, nullCoords)))
    .change(fitBounds);
});
