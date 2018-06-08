import "bootstrap";
import $ from 'jquery';

import { initializeAutocomplete } from "./../components/autocomplete.js";
import { bindSweetAlertButtonDemo } from "./../components/sweet_alert.js";
bindSweetAlertButtonDemo();
initializeAutocomplete();

// document.getElementById('').addEventListener('click', (event) => {
//   swal({
//     title: "Good job!",
//     text: "You clicked the button!",
//     icon: "success",
//   });
// });

