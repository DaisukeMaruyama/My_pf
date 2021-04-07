/*global $*/

$(document).on('turbolinks:load', function() {
  $(function() {
    $('#slider').slick({
      autoplay: true,
      autoplaySpeed: 3000,
      slidesToShow: 3, 
      slidesToScroll: 1, 
      variableWidth:true,
      adaptiveHeight: true,
      centerMode: true,
      centerPadding: "5px",
      
      //レスポンシブ対応
      responsive: [{
      breakpoint: 768, 
      settings: {
      slidesToShow: 2,
      slidesToScroll: 1,
      centerMode: false,
      }
      }]
    });
  });
});
     