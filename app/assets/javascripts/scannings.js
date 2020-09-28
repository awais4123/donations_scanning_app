$(document).ready(function () {

  $("#isbn-search").submit(function () {
    $('.loader').removeClass('d-none');
  });

  $("#isbn-search").on("ajax:success", function (e) {
    data = e.detail[0]
    debugger
    $('.loader').addClass('d-none');
    $('.alert').hide();
    if (data.outcome == 'Keep') {
      $('.keep').show();
    }
    else if (data.outcome == 'Donate') {
      $('.donate').show();
    }
    else if (data.outcome == 'Inspect') {
      $('.inspect').show();
    }
    else if (data.outcome == 'Not Found'){
      $('.not-found').show();

    }
    else if (data.outcome == 'Refilling Tokens') {
      $('.refilling-tokens').show();
    }
    
    setTimeout(function () {
      window.location.reload(1);
    }, 2000);

  });
  $("#isbn-search").on("ajax:error", function (e) {
    console.log("ERROR");
  });
});