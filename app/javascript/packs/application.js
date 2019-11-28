import "bootstrap";
import { activeLink } from '../components/navlink_active_in_navbar';
import { animateHomeContentTabs } from "../components/home_concept_tabs.js";
import { animateFlashes } from '../components/animate_flashes';
import { initModal } from '../components/init_modal';
import { loadDynamicBannerText } from '../components/banner';
import { initUpdateNavbarOnScroll } from '../components/navbar';


animateHomeContentTabs()
activeLink();
animateFlashes();
initModal();
loadDynamicBannerText();
initUpdateNavbarOnScroll();

