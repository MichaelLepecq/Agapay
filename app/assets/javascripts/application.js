//= require rails-ujs
//= require_tree .
//= require jquery
//= require simple_form_extension

function handleEvent(_, target) {
  const cat = document.getElementById(target.id)
  cat.checked = !cat.checked;
  target.classList.toggle("focs")
}

function toggleSidebar(_, target) {
  document.getElementById("sidebar").classList.toggle("open")
}
