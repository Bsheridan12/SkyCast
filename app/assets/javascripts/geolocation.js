searchedLocation = [];
userCoords = [];
formattedAddress = {};
initialLocation = "";

function initialize(callback) {
  var mapOptions = {
    center: { lat: -34.397, lng: 150.644},
    zoom: 8
  };
  var map = new google.maps.Map($('#map-canvas')[0],
    mapOptions);

  
  // Try W3C Geolocation (Preferred)
  if(navigator.geolocation) {
    browserSupportFlag = true;
    navigator.geolocation.getCurrentPosition(function(position) {
      initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
      // grab data to pass to controller
      getFormattedAddress(initialLocation)
      userCoords = ([position.coords.latitude,position.coords.longitude])

      map.setCenter(initialLocation);
    }, function() {
      handleNoGeolocation(browserSupportFlag);
    });
  }
    // Browser doesn't support Geolocation
  else {
    browserSupportFlag = false;
    handleNoGeolocation(browserSupportFlag);
  }

  function handleNoGeolocation(errorFlag) {
    if (errorFlag == true) {
      alert("Geolocation service failed.");
      initialLocation = newyork;
    } else {
      alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
      initialLocation = siberia;
    }
    map.setCenter(initialLocation);
  }
}

function getFormattedAddress(initialLocation) {
  var geocoder = new google.maps.Geocoder();
  geocoder.geocode({'latLng': initialLocation}, function(results, status) {
    console.log(results)
    formattedAddress = { 
      fullAddress:results[3].formatted_address,
      zip:results[3].address_components[0].long_name,
      city:results[3].address_components[1].long_name,
      state: results[3].address_components[3].short_name,
      country: results[3].address_components[4].short_name }
  })
}

function getLatLong(address) {
  var geo = new google.maps.Geocoder;

  geo.geocode({"address":address}, function(results, status) {
    if (status === google.maps.GeocoderStatus.OK) {
      searchedLocation = [results[0].geometry.location.lat(), results[0].geometry.location.lng()];
    } else {
      alert("Geocode was not successful for the following reason: " + status);
    }
  })
}

  $(document).ready(function(){

    initialize();

    setTimeout(function(){
      var request = $.ajax({
        url: "/welcome",
        type: "POST",
        data: {latitude: userCoords[0], longitude: userCoords[1], formatted_address: formattedAddress.fullAddress, zip: formattedAddress.zip, city: formattedAddress.city, state: formattedAddress.state, country: formattedAddress.country }
      })

      request.done(function(response){
        $("#forecast-div").html(response)
      })

    }, 1200)


    $(".new_location").on("submit", function(e) {
      console.log("test")
      e.preventDefault();
      var address = $(this).serialize();

      getLatLong(address);
      
      setTimeout(function(){
        var newLocation =  new google.maps.LatLng(searchedLocation[0], searchedLocation[1])

        getFormattedAddress(newLocation)
      }, 300)

      setTimeout(function(){
      console.log(formattedAddress)
        var request = $.ajax({
          url: "/locations",
          type: "POST",
          data: {latitude: searchedLocation[0], longitude: searchedLocation[1], formatted_address: formattedAddress.fullAddress, zip: formattedAddress.zip, city: formattedAddress.city, state: formattedAddress.state, country: formattedAddress.country}
        });

        console.log(formattedAddress)
        request.done(function(response){
          console.log(response)
        })
      }, 600)
    })

  })
