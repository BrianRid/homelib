function hideTabBodies(){
  document.querySelectorAll(".profil-body").forEach((body) => {
    body.classList.add("d-none")
  })
}

function removeUnderlineProfil(){
  document.querySelectorAll(".profil-link").forEach((link) => {
    link.classList.remove("profil-link-active")
  })
}


function animateHomeContentTabs(){
  if (document.querySelector("#concept")){
    document.querySelectorAll(".profil-link").forEach((link) => {
      link.addEventListener("click", function(e){
        removeUnderlineProfil()
        e.currentTarget.classList.add("profil-link-active")
        hideTabBodies()
        const bodyId = `${e.currentTarget.id}-body`;
        document.querySelector(`#${bodyId}`).classList.remove("d-none");
      })
    });
  }
};

export { animateHomeContentTabs }
