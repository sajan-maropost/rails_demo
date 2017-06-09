$(document).on('turbolinks:load', function() {

	jQuery.validator.addMethod("validName", function(value, element) {
	    return /^[a-z]+$/i.test(value);
	}, "Please enter a valid name");

	$( "#new_user" ).validate( {
		rules: {
			"user[name]": {
				required: true,
				validName: true
			},
			"user[email]": {
				required: true,
				email: true
			},
			"user[password]": {
				required: true,
				minlength: 6
			},
			"user[password_confirmation]": {
				required: true,
				equalTo: "#signup_password"
			}
		},
		messages: {
			"user[name]": {
				required: "Please enter your name"
			},
			"user[email]": {
				required: "Please enter your email",
				email: "Please enter a valid email"
			},
			"user[password]": {
				required: "Please enter a password",
				minlength: "Password should be minimum 6 character"
			},
			"user[password_confirmation]": {
				required: "Please confirm your password",
				equalTo: "Password does not match."
			}
		},
		errorElement: "span",
		errorPlacement: function ( error, element ) {
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

	$( "#new_session" ).validate( {
		rules: {
			"user[email]": {
				required: true
			},
			"user[password]": {
				required: true
			}
		},
		messages: {
			"user[email]": {
				required: "Please enter your email"
			},
			"user[password]": {
				required: "Please enter your password"
			}
		},
		errorElement: "span",
		errorPlacement: function ( error, element ) {
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

	$( "#new_password" ).validate( {
		rules: {
			"user[password]": {
				required: true
			},
			"user[password_confirmation]": {
				required: true,
				equalTo: "#user_password"
			}
		},
		messages: {
			"user[password]": {
				required: "Please enter your new password"
			},
			"user[password_confirmation]": {
				required: "Please confirm your password",
				equalTo: "Password confirmation does not match"
			}
		},
		errorElement: "span",
		errorPlacement: function ( error, element ) {
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

	$( "#change_password" ).validate( {
		rules: {
			"user[current_password]": {
				required: true
			},
			"user[password]": {
				required: true
			},
			"user[password_confirmation]": {
				required: true,
				equalTo: "#user_password"
			}
		},
		messages: {
			"user[current_password]": {
				required: "Please enter your current password"
			},
			"user[password]": {
				required: "Please enter your new password"
			},
			"user[password_confirmation]": {
				required: "Please confirm your password",
				equalTo: "Password confirmation does not match"
			}
		},
		errorElement: "span",
		errorPlacement: function ( error, element ) {
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
