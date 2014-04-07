# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


jQuery ->
	
	jQuery(document).ready ->
		
		jQuery("select#usertype").change ->
			jQuery("div#adminpassworddiv").removeClass("hidden")
			newtype=jQuery("select#usertype").val()
			jQuery("div#adminpassworddiv").addClass("hidden") if newtype=="user"