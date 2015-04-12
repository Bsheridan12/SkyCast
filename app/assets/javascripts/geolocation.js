userCoords = [];

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
  console.log("test")
}


  $(document).ready(function(){

    initialize();


    $("#test").on("click", function(e) {
      e.preventDefault();

      var request = $.ajax({
        url: "/welcome",
        type: "POST",
        data: { latitude: userCoords[0], longitude: userCoords[1] }
      })

      request.done(function(response){
        $("#forecast-div").html(response)
      })
    })
  })
