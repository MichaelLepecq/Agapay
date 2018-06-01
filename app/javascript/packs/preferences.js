const pref = document.querySelectorAll(".focus-box");

// pref.addEventListener( 'click', (event) => {
//   event.currentTarget.classList.toggle('focs');
// });

for (i = 0; i < pref.length; i++) {
    pref[i].addEventListener( 'click', (event) => {
  event.currentTarget.classList.toggle('focs');
});
}
