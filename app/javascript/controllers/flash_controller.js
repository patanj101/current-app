import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = [ "flashMessage" ]


  connect() {
    this.flashMessageTarget.classList.add("animate__delay-2s"); 

    this.animateCSS("fadeOutRight").then(() => {
      this.flashMessageTarget.hidden = true
    });
  }

  close(event) {
    this.flashMessageTarget.classList.remove("animate__delay-2s"); 
    
    this.animateCSS("fadeOutRight").then(() => {
      this.flashMessageTarget.hidden = true
    });
  }

  animateCSS(animation) {
    // We create a Promise and return it
    return new Promise((resolve, _reject) => {
      const animationName = `animate__${animation}`;
      const node = this.element;
      node.classList.add("animate__animated", animationName);

      // When the animation ends, we clean the classes and resolve the Promise
      function handleAnimationEnd(event) {
        event.stopPropagation();
        node.classList.remove("animate__animated", animationName);
        resolve("Animation ended");
      }

      node.addEventListener("animationend", handleAnimationEnd);
    });
  }
}