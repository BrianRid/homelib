import swal from 'sweetalert';

// Custom function for pay rent
const sweetAlertRent = (selector, options = {}, callback = () => {}) => {
  const swalButtons = document.querySelectorAll(selector);
  if (swalButtons) { // protect other pages
    swalButtons.forEach((swalButton) => {
      swalButton.addEventListener('click', (event) => {
        const id = event.currentTarget.dataset.rentId;
        const rentMonth = event.currentTarget.dataset.rentMonth
        const rentAmount = event.currentTarget.dataset.rentAmount
        if (Object.keys(options).length === 0) { // Default options if no arguments given
          options = {
            title: "Payer le loyer",
            text: `Voulez-vous vraiment payer le loyer de ${rentMonth}?`,
            buttons: ["Annuler", `Payer ${rentAmount}€`],
            icon: "warning"
          };
        }
        swal(options).then((value) => {
          if (value) { // submit edit form to opdate rent status
            if (id && rentMonth && rentAmount) {
              const formPay = document.querySelector(`#edit_rent_${id}`);
              const submit = formPay.querySelector('[type="submit"]');
              submit.click();
            }
          }
        });
      });
    });
  }
};

// General function
const initSweetalert = (selector, options = {}, callback = () => {}) => {
  const swalButton = document.querySelector(selector);
  if (swalButton) { // protect other pages
    swalButton.addEventListener('click', () => {
      swal(options).then(callback); // <-- add the `.then(callback)`
    });
  }
};


export { initSweetalert };
export { sweetAlertRent };
