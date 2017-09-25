document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='autocomplete']")

  var options = {
    getValue: "name",
    url: function(phrase) {
      return "/search.json?q=" + phrase;
    },
    categories: [
      {
        listLocation: "movies",
        header: "<strong>Movies</strong>",
      }
    ],
    list: {
      onChooseEvent: function() {
        var url = $input.getSelectedItemData().url
        $input.val("")
        Turbolinks.visit(url)
      }
    }
  }

  $input.easyAutocomplete(options)
});


$(document).ready(function(){
    $(".owl-carousel").owlCarousel({
        margin: 10,
        items: 5,
        responsive:{
            0:{
                items: 2,
                nav: false
            },
            600:{
                items: 3,
                nav: false
            },
            1000:{
                items: 5,
                loop: false
            }
        }
    });
});