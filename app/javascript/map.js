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
        mapId: "DEMO_MAP_ID",
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
                    title: truck['name']
                });
            });
        } else {
            alert('Error loading food truck data');
        }
    };
    xhr.send();

}

initMap();

