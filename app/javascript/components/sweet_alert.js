import swal from 'sweetalert';



function bindSweetAlertButtonDemo() {
  const swalButtons = document.querySelectorAll('.sweet-alert-demo');
  swalButtons.forEach((button) => {
    button.addEventListener('click', (event) => {
      const charityId = event.currentTarget.dataset.id;
      event.preventDefault();
      swal({
        title: "Are you sure?",
        text: "Clicking ok will remove the charity from the list",
        icon: "warning",
        buttons: ["Cancel", "Ok"],
        dangerMode: true,
      })
      .then((willDelete) => {
        if (willDelete) {
          sendDisliked(charityId);
        }
      });
    });
  });
}

const sendDisliked = (charityId) => {
  fetch(`/charities/${charityId}/dislike`, {
    method: "POST",
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    },
    credentials: "same-origin"
  }).then(response => response.text())
  .then(text => eval(text))
}

export { bindSweetAlertButtonDemo };


