function showDetails(apiResponse) {
	var data = apiResponse;
	document.getElementById("detailWindow").style.display = "block";
	document.getElementById("list").style.width = "75%";
	document.getElementById("detailName").innerHTML = "" + data.name;
	document.getElementById("detailSpecification").innerHTML = "" + data.specification;
	document.getElementById("detailPlace").innerHTML = "" + data.place;
	document.getElementById("detailPrice").innerHTML = "" + data.price + " CHF";
	document.getElementById("carId").value = data.id;
	var elements = document.getElementsByClassName('item');
	for (var i = 0; i < elements.length; i++) {
		elements[i].style["margin-left"] = "70px";
		elements[i].style["margin-right"] = "50px";
	}
}
function closeDetails() {
	document.getElementById("item1").style.display = "none";
	document.getElementById("list").style.width = "100%";
	var elements = document.getElementsByClassName('item');
	for (var i = 0; i < elements.length; i++) {
		elements[i].style["margin-left"] = "220px";
		elements[i].style["margin-right"] = "150px";
	}
}
function openLogin(){
	if($("#userId").val() != ""){
		$("#userId").val("");
		$("#usernameId").val("");
		$("#loginname").text("Anmelden");
		if($("#pageId").val() != "overview"){
			goToOverview();
		}
	}else{
		document.getElementById("logindlg").style.display = "block";
		document.getElementById("username").value = "";
		document.getElementById("pw").value = "";
	}
}
function closeLogin(){
	document.getElementById("logindlg").style.display = "none";
	document.getElementById("username").value = "";
	document.getElementById("pw").value = "";
	document.getElementById("errorLogin").innerHTML = "";
}
function initializeForm(apiResponse){
	var data = apiResponse;
	document.getElementById("detailName").innerHTML = "" + data.name;
	document.getElementById("detailSpecification").innerHTML = "" + data.specification;
	document.getElementById("detailPlace").innerHTML = "" + data.place;
	document.getElementById("detailPrice").innerHTML = "" + data.price + " CHF";
	document.getElementById("carId").value = "" + data.id;
	var carimg = document.createElement("img");
	carimg.src = "../images/img_" + data.id + ".jpg";
	carimg.className = "bigcarimg";
	var picture = document.getElementById("picture");
	picture.appendChild(carimg);
}
function storeIds(carId, userId, username, page){
	$("#userId").val(userId);
	$("#carId").val(carId);
	$("#usernameId").val(username);
	$("#loginname").text(username);
	$("#pageId").val(page);
}
function openSuccessMsg(){
	document.getElementById("successmsg").style.display = "block";
}
function login(){
    var username =  $("#username").val();
    var pw = $("#pw").val();

    $.ajax({
        type: "GET",
        url: "http://localhost:8080/user/login?username=" + username + "&password=" + pw,
        timeout: 600000,
        success: function (data) {
        	$("#errorLogin").text("");
        	$("#loginname").text(data.username);
        	 $("#usernameId").val(data.username);
        	$("#userId").val(data.userId);
            console.log("SUCCESS : ", data);
            closeLogin();
        },
        error: function (e) {
            $("#errorLogin").text("Benutzername oder Passwort ist nicht korrekt.");
            $("#loginname").text("Anmelden");
            $("#usernameId").val("");
            $("#userId").val("");
            console.log("ERROR : ", e);
        }
    });
}
function goToForm(){
	var userId = $("#userId").val();
	var carId = $("#carId").val();
	var username = $("#usernameId").val();
	if(userId == "" || username == ""){
		openLogin();
	}else{
		redirectToOtherPage(username,userId,carId,"form")
	}
}
function goToOverview(){
	var userId = $("#userId").val();
	var carId = $("#carId").val();
	var username = $("#usernameId").val();
	redirectToOtherPage(username,userId,carId,"overview");
}
function redirectToOtherPage(username,userId,carId,page){
	var url = 'http://localhost:9080/Autovermietung_frontend/jsp/content.jsp';
	if(userId == "" || username == ""){
		window.location = url;
	}else{
		window.location = url
			+ '?username=' + username
			+ '&token=' + userId
			+ '&carId=' + carId
			+ '&page=' + page;
	}
}