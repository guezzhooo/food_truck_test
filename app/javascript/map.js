let map;

async function initMap() {
    // The location of Uluru
    const position = { lat: 37.753966, lng: -122.447625 };
    // Request needed libraries.
    //@ts-ignore
    const { Map } = await google.maps.importLibrary("maps");
    const { AdvancedMarkerElement } = await google.maps.importLibrary("marker");

    // The map, centered at Uluru
    map = new Map(document.getElementById("map"), {
        zoom: 12,
        center: position,
        mapId: "DEMO_MAP_ID"
    });

    var xhr = new XMLHttpRequest();
    xhr.open('GET', '/api/truck_data/map', true);
    xhr.responseType = 'json';
    xhr.onload = function() {
        var status = xhr.status;
        if (status === 200) {
            xhr.response.forEach(function(truck, index) {
                const marker = new google.maps.Marker({
                    map: map,
                    position: { lat: truck['latitude'] - 0, lng: truck['longitude'] - 0 },
                    title: truck['name'],
                    name: truck['name'],
                    type: truck['facility_type'],
                    address: truck['address'],
                    location: truck['location_description'],
                    food: truck['food_items']
                });
                marker.addListener('click', function() {
                    document.getElementById('food-truck-name').innerHTML = this.name
                    document.getElementById('food-truck-type').innerHTML = this.type
                    document.getElementById('food-truck-address').innerHTML = this.address
                    document.getElementById('food-truck-location').innerHTML = this.location
                    document.getElementById('food-truck-food').innerHTML = this.food
                });
            });
        } else {
            alert('Error loading food truck data');
        }
    };
    xhr.send();

}

initMap();

