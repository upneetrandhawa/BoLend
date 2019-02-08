# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  console.log("DOM is ready")
  scrollLink = $('.scroll');
  scrollLink.click (e) ->
    e.preventDefault()
    $('body,html').animate {scrollTop: $(this.hash).offset().top}, 1000   
