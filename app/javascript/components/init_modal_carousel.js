// Get the modal
const modal_c = document.getElementById("myModal_c");
// Get the button that opens the modal
const btn_c = document.getElementById("myBtn_c");
// Get the <span> element that closes the modal
const span_c = document.getElementsByClassName("close-modal_c")[0];

const initModal_c = () => {
  if (modal_c && btn_c && close_c) {
    // When the user clicks the button, open the modal
    btn_c.onclick = function() {
      modal_c.style.display = "block";
    }
    // When the user clicks on <span> (x), close the modal
    span_c.onclick = function() {
      modal_c.style.display = "none";
    }
    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function(event) {
      if (event.target == modal_c) {
        modal_c.style.display = "none";
      }
    }
  }
}

export { initModal_c };
