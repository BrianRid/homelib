function hideTabBodies(){
  document.querySelectorAll(".profil-body").forEach((body) => {
    body.classList.add("d-none")
  })
}


function animateHomeContentTabs(){
  if (document.querySelector("#concept")){
    document.querySelectorAll(".profil-link").forEach((link) => {
      link.addEventListener("click", function(e){
        console.log(e.currentTarget)
        hideTabBodies()
        let bodyId = `${e.currentTarget.id}-body`;
        document.querySelector(`#${bodyId}`).classList.remove("d-none");
      })
    });
  }
};

export { animateHomeContentTabs }
