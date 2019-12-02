
const hideSubmit = () =>{
  const cards = document.querySelectorAll('#dashboard_new_incident2 .form-check');
  if (cards) {
    const form = document.getElementById('dashboard_new_incident2');
    cards.forEach((card)=>{
      card.addEventListener('click', (e) =>{
        form.submit();
      });
    });
  }
}

const hideSubmitAnswers = () =>{
  const inputRadiobuttons = document.querySelectorAll('#new_incident input.radio_buttons');
  if (inputRadiobuttons) {
    const form = document.getElementById('new_incident');
    inputRadiobuttons.forEach((inputRadioBtn)=>{
      inputRadioBtn.addEventListener('change', (e) =>{
        form.submit();
      });
    });
  }
}


export {hideSubmitAnswers};
export {hideSubmit};
