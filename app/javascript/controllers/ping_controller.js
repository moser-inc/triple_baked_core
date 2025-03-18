import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ping"
export default class extends Controller {
  connect() {
  }

  handleClick() {
    alert("I'm alive!")
  }
}
