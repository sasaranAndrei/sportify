import { Controller } from "stimulus";

export default class extends Controller {
  static target = ["coordinates"]

  connect() {
    console.log('Hello from Stimulus :)')
    if (typeof google != "undefined") {
      this.renderMap();
    }
  }

  renderMap() {
    const lat = parseFloat(this.coordinatesTarget.dataset.lat)
    const lon = parseFloat(this.coordinatesTarget.dataset.lon)
    const coordinates = { lat: lat, lon: lon }
    
    map = new google.maps.Map(this.coordinatesTarget, document.getElementById("map"), {
      center: { lat: 46.77008, lon: 23.59733 },
      zoom: 1,
    });
  }
}
