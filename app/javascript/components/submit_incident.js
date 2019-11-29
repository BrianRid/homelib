
const hideSubmit = () =>{
  const cards = document.querySelectorAll('.form-check');
  if (cards) {
    const form = document.getElementById('dashboard_new_incident');
    cards.forEach((card)=>{
      card.addEventListener('click', (e) =>{
        form.submit();
      });
    });
  }
}

export {hideSubmit};
