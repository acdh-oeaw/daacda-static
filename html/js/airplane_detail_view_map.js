// extract all unique places

const spans = document.querySelectorAll('.dse-place[data-lng]');
const places = Array.from(spans).map(span => {
  const lat = span.dataset.lat;
  const lng = span.dataset.lng;
  const name = span.dataset.name;
  const id = span.dataset.rsid;
  return { lat, lng, name, id };
});
console.log(places);

var map = L.map("airplaneMap").setView([48, 16], 6);

L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
  attribution:
    '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);

places.forEach(place => {
    L.marker([place.lat, place.lng])
        .bindPopup(place.name)
        .addTo(map);
});
