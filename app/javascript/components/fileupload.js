// target file input
// listen to change
// on change get input value
// clean the value to get the document name
// insert value inside label
// OR target the span and insert value into the span

const file2 = document.getElementById('document_file');
const span2 = document.getElementById('file-upload-value');

const getUploadFileName = () => {
file2.addEventListener("change", (event) => {
  span2.innerText = event.currentTarget.value.split('\\').pop(-1);
});
}

export { getUploadFileName };



const photo2 = document.getElementById('incident_photos');
const photo_span2 = document.getElementById('file-upload-value');

const getUploadPhotoName = () => {
photo2.addEventListener("change", (event) => {
  photo_span2.insertAdjacentHTML('beforeend', "<span class='text-white'>" + event.currentTarget.value.split('\\').pop(-1) + "</span>");
});
}

export { getUploadPhotoName };
