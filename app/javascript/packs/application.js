import "bootstrap";
import { activeLink } from '../components/active_navlink';
import { animateHomeContentTabs } from "../components/home_concept_tabs.js";
import { animateFlashes } from '../components/animate_flashes';
import { initModal } from '../components/init_modal';
import { loadDynamicBannerText } from '../components/banner';
import { initUpdateNavbarOnScroll } from '../components/navbar';
import { readMore } from '../components/worker_read_more';


animateHomeContentTabs()
activeLink();
animateFlashes();
initModal();
loadDynamicBannerText();
initUpdateNavbarOnScroll();
readMore();
