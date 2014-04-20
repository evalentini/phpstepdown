# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
	
	jQuery(document).ready ->
		
		
		#show drop off options if patient has left PHP program 
		inphp=jQuery("select#active").val()
		jQuery("div#dropoffonlyinputs").removeClass("hidden") if inphp=="false"
		
		ipdays=parseInt(jQuery("select#ipdays").val())
		jQuery("div#ipdateformgroup").removeClass("hidden") if ipdays>0
		#remove the option of 0 php visits if had 0 IP days 
		window.zeroPhpOptionText=jQuery("select#phpvisits option[value='0']").text()
		window.zeroPhpOptionText="<option value=0>"+window.zeroPhpOptionText+"</option>"
		jQuery("select#phpvisits option[value='0']").remove() unless ipdays>0
		
		
		#hide php date inputs if patient is dropout 
		phpvisits=jQuery("select#phpvisits").val()
		inphp=jQuery("select#active").val()

		jQuery('div#phpstartdateformgroup').removeClass("hidden") if phpvisits>0 or inphp=="true"
		jQuery('div#phpenddateformgroup').removeClass("hidden") if phpvisits>0 or inphp=="true"
		
		
		#add fill in for other if other is selected option
		dropreason=jQuery("select#dropreason_id option:selected").text()
		jQuery('div#otherdetailgroup').removeClass("hidden") if dropreason=="Other"

		jQuery("select#active").change ->
			inphp=jQuery("select#active").val()
			jQuery("div#dropoffonlyinputs").removeClass("hidden") 
			jQuery("div#dropoffonlyinputs").addClass("hidden") unless inphp=="false"	
			
			#check whether dates should show
			phpvisits=parseInt(jQuery("select#phpvisits").val())
			jQuery('div#phpstartdateformgroup').removeClass("hidden")
			jQuery('div#phpenddateformgroup').removeClass("hidden")
			
			jQuery('div#phpstartdateformgroup').addClass("hidden") if phpvisits==0 and inphp=="false"
			jQuery('div#phpenddateformgroup').addClass("hidden") if phpvisits==0 and inphp=="false"

		jQuery("select#ipdays").change ->
			ipdays=parseInt(jQuery("select#ipdays").val())
			
			jQuery("div#ipdateformgroup").removeClass("hidden")
			jQuery("div#ipdateformgroup").addClass("hidden") unless ipdays>0
			#remove the option of 0 php visits if had 0 IP days 
			jQuery("select#phpvisits option[value='0']").remove()
			jQuery("select#phpvisits").prepend(window.zeroPhpOptionText) if ipdays>0

		jQuery("select#dropreason_id").change ->
			dropreason=jQuery("select#dropreason_id option:selected").text()
			jQuery('div#otherdetailgroup').removeClass("hidden") 
			jQuery('div#otherdetailgroup').addClass("hidden") unless dropreason=="Other" 
			
		jQuery("select#phpvisits").change ->
			phpvisits=parseInt(jQuery("select#phpvisits").val())
			inphp=jQuery("select#active").val()
			
			jQuery('div#phpstartdateformgroup').removeClass("hidden")
			jQuery('div#phpenddateformgroup').removeClass("hidden")
						
			jQuery('div#phpstartdateformgroup').addClass("hidden") if phpvisits==0 and inphp=="false"
			jQuery('div#phpenddateformgroup').addClass("hidden") if phpvisits==0 and inphp=="false"
			
		