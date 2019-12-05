
const hideSubmit = () =>{
  const inputRadiobuttons = document.querySelectorAll('#dashboard_new_incident2 input.radio_buttons');
  if (inputRadiobuttons) {
    inputRadiobuttons.forEach((inputRadiobutton)=>{
      inputRadiobutton.addEventListener('change', (e) =>{
        // const form = document.getElementById('dashboard_new_incident2');
        const targetForm = e.currentTarget.form;
        targetForm.querySelector("input[type='submit']").click();
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
        const targetForm = e.currentTarget.form;
        targetForm.querySelector("input[type='submit']").click();
        // form.submit();
      });
    });
  }
}


export {hideSubmitAnswers};
export {hideSubmit};
