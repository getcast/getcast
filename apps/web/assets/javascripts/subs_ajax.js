$('.subs_button').on('click', function() {
	alert($(this).attr("data-id"))
        $.ajax({
		type: "GET",
                url: 'http://getcast.nargothrond.me/subs/',
		data: {podcastid: $(this).attr("data-id")},
                sucess: function(r){

                }
        });


});
