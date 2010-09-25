// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
var user_list = [];

$.ajax({
 type: 'GET',
 url: '/users',
 dataType: "json",
 success: function(data){
    $.each(data, function(index, item) { 
      user_list[index] = { label: item['user'].login, name: item['user'].name};
    });
    $( "#thank_message" ).autocomplete({
      source: user_list
    }).data( "autocomplete" )._renderItem = function( ul, item ) {
        return $( "<li></li>" )
          .data( "item.autocomplete", item )
          .append( "<a>" + item.label + " - " + item.name + "</a>" )
          .appendTo( ul );
      };
 }
})