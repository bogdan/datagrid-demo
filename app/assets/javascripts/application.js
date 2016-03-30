//= require jquery
//= require jquery_ujs
//= require date
//= require date-format
//= require_tree .

Date.format = "yyyy-mm-dd";
$(document).ready(function() {
  sh_highlightDocument();
  $('.date_filter').datePicker({startDate: '2010-01-01'});
  $("#dp-popup").addClass("dp-popup");
});
