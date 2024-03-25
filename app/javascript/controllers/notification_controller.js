import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["notice", "alert"]

  close(event) {
    event.currentTarget.parentElement.style.display = 'none';
  }
}
