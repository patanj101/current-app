// import { Controller } from "@hotwired/stimulus";
// import { DirectUpload } from "@rails/activestorage";

// const input = document.querySelector('input[type=file]')

// // Bind to normal file selection
// input.addEventListener('change', (event) => {

//   Array.from(input.files).forEach(file => uploadFile(file))
//   // you might clear the selected files from the input
//   input.value = null
// })



import { Controller } from "@hotwired/stimulus";
import { DirectUpload } from "@rails/activestorage";
// import Dropzone from "dropzone";


// Connects to data-controller="dropzone"
export default class extends Controller {
  static targets = ["input", "output", "filenameDiv", "submitButton"];

  connect() {
    this.bindEvents();
  }

  bindEvents() {
    this.inputTarget.addEventListener('change', (event) => {
      showElement(this.filenameDivTarget);
      addText(this.outputTarget, this.inputTarget.files[0].name);
      enableButton(this.submitButtonTarget);
      // uploadFile(this.inputTarget);
      // Array.from(this.inputTarget.files).forEach(file => new Uploader(file, this.inputTarget).start())
      const uploader = new Uploader(this.inputTarget.files[0], this.inputTarget.dataset.directUploadUrl)

      uploader.process((error, blob) => {
        if (error) {
          // Handle the error
        } else {
          // Add an appropriately-named hidden input to the form with a
          //  value of blob.signed_id so that the blob ids will be
          //  transmitted in the normal upload flow
          // const hiddenField = document.createElement('input')
          // hiddenField.setAttribute("type", "hidden");
          // hiddenField.setAttribute("value", blob.signed_id);
          // hiddenField.name = input.name
          // document.querySelector('form').appendChild(hiddenField)
        }
      })


    });
  }

  reset(event) {
    this.inputTarget.value = null;
    hideElement(this.filenameDivTarget);
    removeText(this.outputTarget, this.inputTarget.files[0].name);
    disableButton(this.submitButtonTarget);
  }

}


class Uploader {
  constructor (file, url, uuid) {
    this.upload = new DirectUpload(file, url, this)
    this.uuid = uuid
  }

  process (callback) {
    this.upload.create(callback)
  }

  directUploadWillStoreFileWithXHR (request) {
    request.upload.addEventListener('progress', event => {
      this.directUploadDidProgress(event)
    })
  }

  directUploadDidProgress (event) {
    const factor = Math.round(event.loaded / event.total) * 100
    const progressBar = document.querySelector('#progressBar')
    const progressIndicator = document.querySelector('#progressIndicator')
    progressIndicator.textContent = factor + '%'
    removeClassAttributeStartingWith(progressBar, 'w-');
    progressBar.classList.add('w-'+getClosestBarWidth(Math.round(event.loaded / event.total)))
  }
}


function getClosestBarWidth(needle) {
  const potential_values = ['0', '1/2', '2/5', '3/5', '1/3', '2/3', '1/4', '3/4', '1/5', '4/5', '1/6', '5/6', '1'];

  const closest_value = potential_values.reduce((a, b) => {
    return Math.abs(eval(b) - needle) < Math.abs(eval(a) - needle) ? b : a;
  });

  if (closest_value == '1') {
    return 'full'
  } else {
    return closest_value
  }
}

function removeClassAttributeStartingWith(el, pattern) {
  el.classList.forEach(item=>{
    if(item.startsWith(pattern)) {
      el.classList.remove(item) ;
    }
  })
}


function disableButton(el) {
  el.classList.add('opacity-25');
  el.disabled = true;
}

function enableButton(el) {
  el.classList.remove('opacity-25');
  el.disabled = false;
}

function hideElement(el) {
  el.classList.add('hidden');
}

function showElement(el) {
  el.classList.remove('hidden');
}

function addText(el, text) {
  el.textContent = text;
}

function removeText(el, text) {
  el.textContent = "";
}





