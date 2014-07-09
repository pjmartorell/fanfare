//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require best_in_place
//= require jquery.facebox

// Loads all Bootstrap javascripts
//= require bootstrap-sprockets

jQuery(document).ready(function($) {
  // Facebox
  $('a[rel*=facebox]').facebox();
  // Best in place
  jQuery(".best_in_place").best_in_place();
})