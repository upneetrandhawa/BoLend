// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

var map = null;

function initMap(items, user_addr){
    
    //Set default location
    var location;
    var marker = null;

    //If user is not signed in or does not have a valid address
    if (user_addr == null || user_addr["lat"] == null || user_addr["lng"] == null){
        location = {lat: 43.653908, lng: -79.384293}; //toronto
        zoom = 12;
        
    }
    else{
        location = user_addr
        zoom = 15
    }
    
    
    //Initalize the map
    map = new google.maps.Map(document.getElementById('map'), {
        center: location,
        zoom: zoom,
        mapTypeControl: false,
        streetViewControl: false,
        styles: [
           
            {
              "featureType": "poi",
              "stylers": [
                {
                  "visibility": "off"
                }
              ]
            },
        ]
    });

    //Add items marker
    var infowindow = new google.maps.InfoWindow();
    for (var i = 0; i < items.length; i++){    
           
        itemLocation = {lat: items[i].lat, lng: items[i].lng};
        var marker = new google.maps.Marker({
            position: itemLocation,
            map: map,
            url: items[i].url
        });

        var content = items[i].description;
        console.log(items[i].description);
        //Add on click listener to open item's show page when clicked
        google.maps.event.addListener(marker, 'click', function() {
            window.location.href = this.url;
        });

        //Open item's info box when hovered to the marker 
        google.maps.event.addListener(marker,'mouseover', (function(marker,content,infowindow){ 
            return function() {
               infowindow.setContent(content);
               infowindow.open(map,marker);
            };
        })(marker,content,infowindow)); 
        
        google.maps.event.addListener(marker, 'mouseout', function(){
            infowindow.close();
        });
        
    }
}

