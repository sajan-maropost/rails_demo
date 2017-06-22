$(document).on('turbolinks:load', function() {

	$(".edit-btn").on('click', function(){
		$(this).parent().hide();
		$(this).parent().siblings(".edit-form-div").show();
	})

	$(".cancel-btn").on('click', function(){
		$(this).parents('.edit-form-div').hide();
		$(this).parents('.edit-form-div').siblings(".image-name").show();
	})

  $.ajax({
    url: "/images/count",
    cache: false
  });
})