//= require rails-ujs
//= require_tree .
//= require jquery
//= require simple_form_extension

function handleEvent(_, target) {
  var cat = document.getElementById(target.id)
  cat.checked = !cat.checked;
  target.classList.toggle("focs")
}

function toggleSidebar(_, target) {
  document.getElementById("sidebar").classList.toggle("open")
}

function toggleSearchbar(_, target) {
  document.getElementById("search-bloc").classList.toggle("open-search")
}

function toggleMenu(_, target) {
  document.getElementById("burger-menu").classList.toggle("open-menu")
}
