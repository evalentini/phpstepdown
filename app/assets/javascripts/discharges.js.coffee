# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	
	jQuery(document).ready ->
		
		#show drop off options if patient has left PHP program 
		inphp=jQuery("select#active").val()
		jQuery("div#dropoffonlyinputs").removeClass("hidden") if inphp=="false"
		
		#add fill in for other if other is selected option
		dropreason=jQuery("select#dropreason_id option:selected").text()
		jQuery('div#otherdetailgroup').removeClass("hidden") if dropreason=="Other"

		jQuery("select#active").change ->
			inphp=jQuery("select#active").val()
			jQuery("div#dropoffonlyinputs").removeClass("hidden") 
			jQuery("div#dropoffonlyinputs").addClass("hidden") unless inphp=="false"	


		jQuery("select#dropreason_id").change ->
			dropreason=jQuery("select#dropreason_id option:selected").text()
			jQuery('div#otherdetailgroup').removeClass("hidden") 
			jQuery('div#otherdetailgroup').addClass("hidden") unless dropreason=="Other" 