const flashes = document.querySelector('.alert-dismissible');

const removeFlashes = () => {
      flashes.classList.add('leave');
      flashes.classList.remove('show');
    }

const animateFlashes = () => {
  if (flashes) {
    setTimeout(removeFlashes, 4000);
  }
}

export { animateFlashes };
