import "bootstrap";
import { activeLink } from '../components/active_navlink';
import { animateHomeContentTabs } from "../components/home_concept_tabs.js";
import { animateFlashes } from '../components/animate_flashes';
import { initModal } from '../components/init_modal';
import { loadDynamicBannerText } from '../components/banner';
import { initUpdateNavbarOnScroll } from '../components/navbar';
import { initLightGallery } from '../components/init_lightgallery';
import { readMore } from '../components/worker_read_more';
import {hideSubmit} from '../components/submit_incident';
import {hideSubmitAnswers} from '../components/submit_incident';
import { sweetAlertRent } from '../components/init_sweetalert';
import { initSweetalert } from '../components/init_sweetalert';
import "../plugins/flatpickr";
import { getUploadFileName, getUploadPhotoName } from "../components/fileupload"
// import { loadDynamicNameText } from "../components/animate_name_dashboard";


animateHomeContentTabs();
activeLink();
animateFlashes();

loadDynamicBannerText();
initUpdateNavbarOnScroll();
initLightGallery();
readMore();
hideSubmit();
window.hideSubmitAnswers = hideSubmitAnswers;
hideSubmitAnswers();
// loadDynamicNameText();

const file2 = document.getElementById('document_file');
if (file2) {
getUploadFileName();
}
const photo2 = document.getElementById('incident_photos');
if (photo2) {
getUploadPhotoName();
}


// Activate a WARNIG sweetAlert before to pay a rent
sweetAlertRent('.btn-pay-rent');

// Active sweetAlert before to delete an incident
initSweetalert('#delete-incident-btn', {
  title: "Êtes-vous sûr de vouloir supprimer cet incident?",
  text: "Cette action ne pourra pas être inversée",
  icon: "warning",
  buttons: ["Annuler", true]
}, (value) => {
  if (value) {
    const link = document.querySelector('#delete-incident-link');
    link.click();
  }
});

// if(document.querySelector("#dashboard")){
//
// }

