import Typed from 'typed.js';

const text = document.querySelector('#banner-typed-text');

const loadDynamicBannerText = () => {
  if (text) {
    new Typed('#banner-typed-text', {
      strings: ["Libérez vous des contraintes de votre logement"],
      typeSpeed: 50,
      loop: false
    });
  }
}

export { loadDynamicBannerText };
