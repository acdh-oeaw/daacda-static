var map = L.map("airplaneMap");

L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
  attribution:
    '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);

// Create a marker cluster group
const markers = L.markerClusterGroup();

const spans = document.querySelectorAll(".dse-place[data-lng]");
const places = Array.from(spans).map((span) => {
  const lat = span.dataset.lat;
  const lng = span.dataset.lng;
  const name = span.dataset.name;
  const id = span.dataset.rsid;
  return { lat, lng, name, id };
});

places.forEach((place) => {
  const marker = L.marker([place.lat, place.lng])
    .bindPopup(place.name);
  marker.id = place.id;

  marker.on("mouseover", function (e) {
    document.querySelectorAll(`[data-rsid="${e.target.id}"]`).forEach((el) => {
      el.classList.add("highlight");
    });
  });
  marker.on("mouseout", function (e) {
    document.querySelectorAll(`[data-rsid="${e.target.id}"]`).forEach((el) => {
      el.classList.remove("highlight");
    });
  });
  
  // Add marker to cluster group instead of directly to map
  markers.addLayer(marker);
});

// Add marker cluster group to map
map.addLayer(markers);

if (places.length === 1) {
    const place = places[0];
    map.setView([place.lat, place.lng], 7);
} else {
    map.fitBounds(markers.getBounds(), { padding: [50, 50] });
}