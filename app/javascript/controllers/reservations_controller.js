import { Controller } from "stimulus"

export default class extends Controller {
  static targets  = [ "field", "title" ]
  // static values = {
  //   title: String
  // }

  initialize() {
    this.fieldTarget.value = '1'
  }

  updateTimetable(selectedField) {
    console.log(selectedField)
    console.log(window.location.pathname)
    console.log(window.location.search)
    // $.ajax({
    //   url: '/reservati'
    // })
  } 

  refreshTimetable() {
    console.log(this.selectedFieldLabel)
    this.titleTarget.textContent = `${this.selectedFieldLabel} Timetable`
    // updateTimetable(this.selectedFieldValue)

    console.log(this.selectedFieldValue)
    console.log(window.location.pathname)
    console.log(window.location.search)
    $.ajax({
      url: `${window.location.pathname}${window.location.search}&field_id=${this.selectedFieldValue}`,
      url: `/reservations/timetable${window.location.search}&field_id=${this.selectedFieldValue}`,
      success: function(data) {
        timetable = data.timetable
        console.log('s-a facut ajax callu vez domne')
        console.log(timetable)
        
        // o sa fac asa cu methoda asta ciobaneasca
        $('#slot-2022-06-11-20').removeClass('error-notice-background');

        // $('#timetable').replaceWith("<%= j(render partial: 'reservations/timetable', locals: { timetable: @timetable } ) %>")
        // $('#timetable').html('= j render ()')
        // updateThatShit();
        

        

      }
    })
  }

  get selectedFieldValue() {
    return this.fieldTarget.value
  }

  get selectedFieldLabel() {
    const field = this.fieldTarget
    
    return field.options[field.selectedIndex].text
  }
}
