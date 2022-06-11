import { Controller } from "stimulus"

export default class extends Controller {
  static targets  = [ "field", "title" ]
  // static values = {
  //   title: String
  // }

  initialize() {
    this.fieldTarget.value = '1'
  }

  refreshTimetable() {
    console.log(this.selectedFieldTag)
    this.titleTarget.textContent = `${this.selectedFieldTag} Timetable`
  }

  get selectedFieldTag() {
    const field = this.fieldTarget
    
    return field.options[field.selectedIndex].text
  }
}
