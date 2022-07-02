import { Controller } from "stimulus"

export default class extends Controller {
  static targets  = [ "field", "title" ]

  initialize() {
    this.fieldTarget.value = '1'
  }

  refreshTimetable() {
    this.titleTarget.textContent = `${this.selectedFieldLabel} Timetable`

    $.ajax({
      url: `/reservations/timetable${window.location.search}&field_id=${this.selectedFieldValue}`,
      success: function(data) {
        const timetable = data.timetable

        $('.timetable-slot').each(function (index, element) {
          const date = element.getAttribute('date')
          const hour = element.getAttribute('hour')
          
          element.removeAttribute('class')
          element.classList.add('timetable-slot')

          const occupiedClass = timetable[date][hour] ? 'occupied-slot' : 'free-slot'
          element.classList.add(occupiedClass)
        })
      },
      error: function(xhr, ajaxOptions, thrownError){
        alert(xhr.status);
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
