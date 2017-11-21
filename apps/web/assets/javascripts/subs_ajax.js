$(document).ready(function () {
	$('.subs_button').on('click', function() {
		var sub = $(this).attr("data-SUB");
		if (sub == "False")
		{
		        $.ajax({
				type: "GET",
		                url: 'http://getcast.nargothrond.me/subs/',
				data: {podcastid: $(this).attr("data-id")},
		                success: function(){
		                	$('.subs_button').html("Unsubscribe");
					$('.subs_button').attr("data-SUB", "True")
				}
		        });
		}
		else if(sub == "True")
		{
			$.ajax({
				type: "GET",
		                url: 'http://getcast.nargothrond.me/unsubs/',
				data: {podcastid: $(this).attr("data-id")},
		                success: function(){
					$('.subs_button').html("Subscribe");
					$('.subs_button').attr("data-SUB", "False")
		                }
		        });
		}
	
	}); 
});
