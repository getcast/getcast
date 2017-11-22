$('.delete-button').on('click', function() {
	alert($(this).attr("data-id"))
        $.ajax({
		type: "GET",
                url: 'http://getcast.nargothrond.me/mosaic/delete/',
		data: {podcastid: $(this).attr("data-id")},
                sucess: function(r){

                }
        });


});
