$(document).on('turbolinks:load', function() {

	jQuery.validator.addMethod("validName", function(value, element) {
	    return /^[a-z]+$/i.test(value);
	}, "Please enter a valid name");

	jQuery.validator.addMethod("onlyNumber", function(value, element) {
		if(value.length > 0){
	    	return /^\d+$/.test(value);
		} else {
			return true;
		}
	}, "Phone number can contain numericals only");

	$( "#new_user_query" ).validate( {
		rules: {
			"user_query[name]": {
				required: true,
				validName: true
			},
			"user_query[email]": {
				required: true,
				email: true
			},
			"user_query[mobile]": {
				onlyNumber: true,
				minlength: 10
			},
			"user_query[description]": {
				required: true
			}
		},
		messages: {
			"user_query[name]": {
				required: "Please enter your name"
			},
			"user_query[email]": {
				required: "Please enter your email",
				email: "Please enter a valid email"
			},
			"user_query[mobile]": {
				minlength: "Phone number should be minimum 10 digit"
			},
			"user_query[description]": {
				required: "Please enter your message"
			}
		},
		errorElement: "span",
		errorPlacement: function ( error, element ) {
			// Add the `help-block` class to the error element
			error.addClass( "help-block" );

			if ( element.prop( "type" ) === "checkbox" ) {
				error.insertAfter( element.parent( "label" ) );
			} else {
				error.insertAfter( element.parent() );
			}
		},
		highlight: function ( element, errorClass, validClass ) {
			$( element ).parents( ".col-sm-5" ).addClass( "has-error" ).removeClass( "has-success" );
		},
		unhighlight: function (element, errorClass, validClass) {
			$( element ).parents( ".col-sm-5" ).addClass( "has-success" ).removeClass( "has-error" );
		}
	} );
});
