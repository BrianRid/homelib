import flatpickr from "flatpickr"
import "flatpickr/dist/flatpickr.min.css" // Note this is important!
import "flatpickr/dist/themes/light.css"


import { French } from "flatpickr/dist/l10n/fr.js"

flatpickr(".datepicker", {
  altInput: true,
  altFormat: "j F Y",
  dateFormat: "d-m-Y",
  "locale": French,

  // <%= I18n.l(rent.date,  format: '%B', locale: :'fr').capitalize %>
})
