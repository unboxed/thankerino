// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var user_list = [];

$.ajax({
 type: 'GET',
 url: '/users',
 dataType: "json",
 success: function(data){
    $.each(data, function(index, item) {
      user_list[index] = {label: item.name};
    });

    $( "#thank_message" ).autocomplete({
      source: user_list
    })
 }
})