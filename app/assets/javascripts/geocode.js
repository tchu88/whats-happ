function setupGeocoding(){
  function isBlank(str) { return (!str || /^\s*$/.test(str)); }
  function setLatLon(coords) {
    $('#subscription_longitude').val(coords.lon);
    $('#subscription_latitude').val(coords.lat);
  }
  function geocode() {
    var address = $(this).val();

    // clear hidden fields and return if address is blank
    if (isBlank(address)) {
      setLatLon({lat: null, lon: null});
      return;
    }

    var url = "http://nominatim.openstreetmap.org/search?q="+
              encodeURIComponent(address)+
              "&format=json&limit=1&addressdetails=1";

    $.getJSON(url, _.compose(setLatLon, _.first));
  }

  $('#subscription_address').change(geocode);
}

$(setupGeocoding);
