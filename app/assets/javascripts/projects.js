
$(document).on("turbolinks:load", function() {

    var indexInfo = [
        {
            title: 'Everything is Figureout<span class=\"mobileHyphen\">-</span>able!',
            info: 'Some things that you will never hear me say are "I cant do that" or "I dont know how". I borrowed the phrase Everything is Figureoutable from <a href="https://www.marieforleo.com/" class="marieLink" target="_blank">Marie Forleo</a> but the idea that there is nothing that I can\'t figure out how to do given sometime to work through it has been my mental montra for as long as I can remember.'
        },
        {
            title: 'Making is my Passion!',
            info: 'The opportunity to make things for a living is what I have been preparing to do for the last 10 years.  Very few things bring me more joy than finding a need or reason to start and complete a project. Being wired to constantly want to improve by reading, watching, listening or mentored guidence allows me to be versatile to any team. Logic and common sense are my north star.'
        }
    ]

    var slideTimer = null;
    var current = 0;
    slide(current);
    slideTimer = setInterval(function() {slide(current)}, 14000);
    
    function slide(c) {
        $(".headline").fadeOut( "slow", function() {
            $(".headline-title").html(indexInfo[c].title);
            $(".headline-info").html(indexInfo[c].info);
            if (c == 0) {
                $(".c1").css("color", "#FFE373");
                $(".c2").css("color", "white");
            } else {
                $(".c1").css("color", "white");
                $(".c2").css("color", "#FFE373");
            }
            $(".headline").fadeIn( "slow");
            if (c == indexInfo.length - 1) {
                current = 0;
            } else {
                current += 1;
            }
        });
    }

    $(".headline").hover( function() {
        clearInterval(slideTimer);
    }, function() {
        slide(current);
        slideTimer = setInterval(function() {slide(current)}, 14000);
    } )

    $(".c1").click(function() {
        clearInterval(slideTimer);
        current = 0
        slide(current);
        slideTimer = setInterval(function() {slide(current)}, 14000);

    });

    $(".c2").click(function() {
        clearInterval(slideTimer);
        current = 1
        slide(current);
        slideTimer = setInterval(function() {slide(current)}, 14000);

    });

    $(".project-image").click(function() {
        console.log("Image");
        console.log($(this).attr("src"));

        $('.view-project-image').css({'display': 'block'});
        $(".image-obj").html("<img src=" + $(this).attr("src") + ">");
        
    });

    $(".image-close").click(function() {
        $('.view-project-image').css({'display': 'none'});
    });

    $(".view-project-image").click(function() {
        $('.view-project-image').css({'display': 'none'});
    });

    $("#home-projects .category-item").click(function() {
        console.log("Here");
        console.log($(this).data("item"));
        window.location.href = "/details?id=" + $(this).data("item");
    });

    if ($(".selectedProject").length > 0) {
        $('html, body').animate({
            scrollTop: $(".selectedProject").offset().top
        }, 2000);
    }

    var tTimer = null;
    var tIsOpen = false;
    var tWidth = $( ".twilio-box" ).width() + 26;
    $('.twilio-box').css({'right': -tWidth});

    $('.twilio').click(function() {
        $('.twilio-box').css({'display': 'block'});
        $( ".twilio-box" ).animate({
            right: 63,
          }, 750, "linear", function() {
            // Animation complete.
            tIsOpen = true;
            tTimer = setInterval(closeTwilioBox, 15000);
          });
    });

    $('.twilio-close').click(function() {
        clearInterval(tTimer);
        $( ".twilio-box" ).animate({
            right: -tWidth,
          }, 750, "linear", function() {
            // Animation complete.
            tIsOpen = false;
            $('.twilio-box').css({'display': 'none'});
          });
    });

    function closeTwilioBox() {
        $('.twilio-close').click();
    }

    var sWidth = $( ".stripe-box" ).width();
    var winWidth = $( window ).width();
    var sOpen;
    var sClosed;
    var sIsOpen = false;

    //Close stripe box to start
    if (winWidth < 768) {
        sOpen = {left: 5};
        sClosed = {left: -sWidth -30};

        $('.stripe-box').css({width: $( window ).width() - 30});
        $('.stripe-box').css(sClosed);
        
    } else {
        sOpen = {left: 20};
        sClosed = {left: -sWidth - 37};

        $('.stripe-box').css(sClosed);
    }

    $(window).resize(function() {

        tWidth = $( ".twilio-box" ).width() + 26;
        if (!tIsOpen) {
            $('.twilio-box').css({'right': -tWidth});
        }

        winWidth = $(window).width();

        if (winWidth < 768) {
            $('.stripe-box').css({width: $( window ).width() - 30});
            sWidth = $( ".stripe-box" ).width();
            if (!sIsOpen) {
                $('.stripe-box').css({width: $( window ).width() - 30, left: -sWidth - 30});
            } else {
                $('.stripe-box').css({left: 5});
            }
            sClosed = {left: -sWidth -30};
            sOpen = {left: 5};
        } else {
            $('.stripe-box').css({width: 400});
            sWidth = $( ".stripe-box" ).width();
            sClosed = {left: -sWidth -30};
            sOpen = {left: 20};
            $('.stripe-box').css(sOpen);
        }
        
        
    }); 

    $('.stripe1').click(function() {
        $('.stripe-box').css({display: 'block'});
        $( ".stripe-box" ).animate(
            sOpen, 750, "linear", function() {
            // Animation complete.
            sIsOpen = true;
        });
    });

    $('.stripe').click(function() {
        $('.stripe-box').css({display: 'block'});
        $( ".stripe-box" ).animate(
            sOpen, 750, "linear", function() {
            // Animation complete.
            sIsOpen = true;
        });
    });

    $('.stripe-close').click(function() {
        $( ".stripe-box" ).animate(
            sClosed,
            750, "linear", function() {
            // Animation complete.
            $('.stripe-box').css({display: 'none'});
            sIsOpen = false;
        });
    });

    var stripe = Stripe('pk_live_jHOEm20gdpYlMWBt9AnK1HxH00qZ7lAAn5');
    var elements = stripe.elements();

    // Custom styling can be passed to options when creating an Element.
    var style = {
        base: {
        // Add your base input styles here. For example:
        fontSize: '16px',
        color: "#32325d",
        }
    };
  
    // Create an instance of the card Element.
    var card = elements.create('card', {style: style});

    // Add an instance of the card Element into the `card-element` <div>.
    card.mount('#card-element');

    card.addEventListener('change', function(event) {
        var displayError = document.getElementById('card-errors');
        if (event.error) {
            displayError.textContent = event.error.message;
        } else {
            displayError.textContent = '';
        }
    });

    var form = document.getElementById('payment-form');

    form.addEventListener('submit', function(event) {
        event.preventDefault();

        stripe.createToken(card).then(function(result) {
            if (result.error) {
            // Inform the customer that there was an error.
            var errorElement = document.getElementById('card-errors');
            errorElement.textContent = result.error.message;
            } else {
            // Send the token to your server.
            $( ".stripe-box" ).animate({
                left: -sWidth,
              }, 750, "linear", function() {
                // Animation complete.
              });

            stripeTokenHandler(result.token);
            }
        });
    });

    function stripeTokenHandler(token) {
        // Insert the token ID into the form so it gets submitted to the server
        var form = document.getElementById('payment-form');
        var hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'stripeToken');
        hiddenInput.setAttribute('value', token.id);
        form.appendChild(hiddenInput);
      
        // Submit the form
        form.submit();
    }

});