import Typed from 'typed.js';

const text = document.querySelector('#banner-typed-text');

const loadDynamicBannerText = () => {
  if (text) {
    new Typed('#banner-typed-text', {
      strings: ["Libérez vous des contraintes de votre appartement"],
      typeSpeed: 45,
      loop: false,
      showCursor: false
    });
  }
}

export { loadDynamicBannerText };
