// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(document).ready(function(){
  divs = "#flash_success, #flash_notice, #flash_error, #flash_alert";
  $(divs).fadeIn(1000).fadeOut(10000);
});