import Typed from 'typed.js';

const text = document.querySelector('#name-typed-text');

const loadDynamicNameText = () => {
  if (text) {
    const name = document.getElementById('name-typed-text').dataset.user;
    new Typed('#name-typed-text', {
      strings: [`Bonjour ${name}`],
      typeSpeed: 10,
      loop: false,
      showCursor: false
    });
  }
}

export { loadDynamicNameText };
