const cards = document.querySelectorAll('div.card-worker');

const toggleClass = (elt_one, elt_two) => {
  elt_one.classList.toggle('show');
  elt_one.classList.toggle('hide');
  elt_two.classList.toggle('hide');
  elt_two.classList.toggle('show');
}

const readMore = () => {
  if (cards) {
    cards.forEach((card) => {
      const link = card.querySelector('.worker-description span.show');
      const textToShow = card.querySelector('.worker-description span.hide');;
      if (link && textToShow) {
        link.addEventListener('click', (e) => {
          e.preventDefault();
          toggleClass(link, textToShow);
        });
        textToShow.addEventListener('click', (e) => {
          e.preventDefault();
          toggleClass(link, textToShow);
        });
      }
    });
  }
}

export { readMore };
