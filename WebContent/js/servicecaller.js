function login(){
	    var username =  $("#username").val();
	    var pw = $("#pw").val();

	    $.ajax({
	        type: "GET",
	        url: "http://localhost:8080/user/login?username=" + username + "&password=" + pw,
	        timeout: 600000,
	        success: function (data) {

	            $("#logindlg").text(data);
	            console.log("SUCCESS : ", data);

	        },
	        error: function (e) {

	            $("#logindlg").text(e.responseText);
	            console.log("ERROR : ", e);

	        }
	    });
	}

function submit(){
    var data = clientPost {
        firstname:  $("#input1").val(),
        lastname: $("#input2").val()
    };

    $.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: "/test/url/post",
        data: data,
        // http://api.jquery.com/jQuery.ajax/
        // https://developer.mozilla.org/en-US/docs/Web/API/FormData/Using_FormData_Objects
        processData: false, // prevent jQuery from automatically transforming
							// the data into a query string
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {

            $("#result").text(data);
            console.log("SUCCESS : ", data);

        },
        error: function (e) {

            $("#result").text(e.responseText);
            console.log("ERROR : ", e);

        }
    });
}