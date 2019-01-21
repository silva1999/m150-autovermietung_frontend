/**
 * @author 	Leandro Silva
 * @date 	21.01.2019
 * @version	1.0
 * Inspiration for ajax call: https://stackoverflow.com/questions/14220321/how-do-i-return-the-response-from-an-asynchronous-call
 * 
 * External javascript functions
 */

/*
 * -------------- General functions --------------------------
 */

/* Open login dialog, or logout and redirect to start */
function openLogin(){
	/* logout */
	if($("#userId").val() != ""){
		$("#userId").val("");
		$("#usernameId").val("");
		$("#loginname").text("Anmelden");
		if($("#pageId").val() != "overview"){
			goToOverview();
		}
	}
	/* Open login dialog*/
	else{
		document.getElementById("logindlg").style.display = "block";
		document.getElementById("username").value = "";
		document.getElementById("pw").value = "";
	}
}

/* close login dialog */
function closeLogin(){
	document.getElementById("logindlg").style.display = "none";
	document.getElementById("username").value = "";
	document.getElementById("pw").value = "";
	document.getElementById("errorLogin").innerHTML = "";
}

/* Store credentials in page */
function storeIds(carId, userId, username, page){
	$("#userId").val(userId);
	$("#carId").val(carId);
	$("#usernameId").val(username);
	$("#loginname").text(username);
	$("#pageId").val(page);
}

/* call login endpoint */
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

/* Redirect to form page */
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

/* Redirect to overview page */
function goToOverview(){
	var userId = $("#userId").val();
	var carId = $("#carId").val();
	var username = $("#usernameId").val();
	redirectToOtherPage(username,userId,carId,"overview");
}

/* Redirect function */
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
/*
 * -------------- Overview functions --------------------------
 */

/* Open detail dialog */
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

/* Close detail dialog */
function closeDetails() {
	document.getElementById("item1").style.display = "none";
	document.getElementById("list").style.width = "100%";
	var elements = document.getElementsByClassName('item');
	for (var i = 0; i < elements.length; i++) {
		elements[i].style["margin-left"] = "220px";
		elements[i].style["margin-right"] = "150px";
	}
}

/* Call endpoint and get car list */
function getCars(callback){
    $.ajax({
        type: "GET",
        url: "http://localhost:8080/cars",
        timeout: 600000,
        success: callback,
        error: function (e) {
            console.log("ERROR : ", e);
        }
    });
}

/* Call endpoint and get car by id */
function getCarByIdWithCallback(id, callback){
    $.ajax({
        type: "GET",
        url: "http://localhost:8080/cars/" + id,
        timeout: 600000,
        success: callback,
        error: function (e) {
            console.log("ERROR : ", e);
        }
    });
}

/* create car list page with proper data */
function createCarList(apiresponse){
	var data = apiresponse;
	var carlist = document.getElementById("list");
	for(var i = 0; i < data.length; i++){
		var divitem = document.createElement("div");
		divitem.className = "item";
		var carId = data[i].id;
		//https://stackoverflow.com/questions/30476721/passing-parameter-onclick-in-a-loop
		divitem.onclick = (function (carId, showDetails) {
			return function(){
				getCarByIdWithCallback(carId, showDetails);
			}
		})(carId, showDetails);
		
		var carimg = document.createElement("img");
		carimg.src = "../images/img_" + data[i].id + ".jpg";
		carimg.className = "carimg";
		
		var carinfo = document.createElement("div");
		carinfo.className = "carinfo";
		carinfo.innerHTML = "" + data[i].name + " " + data[i].specification;
		
		divitem.appendChild(carimg);
		divitem.appendChild(carinfo);
		carlist.appendChild(divitem);
	}
}

/*
 * -------------- Rent car functions --------------------------
 */

/* Load page and prepare form */
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

/* Show success dialog */
function openSuccessMsg(){
	document.getElementById("successmsg").style.display = "block";
}

/* Call endpoint and get car by id */
function getCarById(callback){
	var id = $("#carId").val();
    $.ajax({
        type: "GET",
        url: "http://localhost:8080/cars/" + id,
        timeout: 600000,
        success: callback,
        error: function (e) {
            console.log("ERROR : ", e);
        }
    });
}

/* Call endpoint and book car */
function rentCar(){
    var carId =  $("#carId").val();
    var userId= $("#userId").val();
    var startdate=  $("#startDate").val();
    var enddate= $("#endDate").val();

    $.ajax({
        type: "POST",
        url: "http://localhost:8080/rent/"+ carId + 
        "?userId=" + userId + "&startdate=" + startdate +
        "&enddate=" + enddate,
        timeout: 600000,
        success: function (data) {
        	document.getElementById("formerror").style.display = "none";
        	$("#formerror").text("");
            console.log("SUCCESS : ", data);
            openSuccessMsg();
        },
        error: function (e) {
            console.log("ERROR : ", e);
            console.log("Status : ", e.status);
            if(e.status == "404"){
            	document.getElementById("formerror").style.display = "none";
            	console.log("ERREICHT : ", e.status);
            	goToOverview();
            }
            if(e.status == "405"){
            	console.log("ERREICHT : ", e.status);
            	$("#formerror").text("Bitte geben Sie korrekte Daten ein.");
            	document.getElementById("formerror").style.display = "block";
            }
            if(e.status == "406"){
            	console.log("ERREICHT : ", e.status);
            	$("#formerror").text("Das Auto ist für diesen Zeitpunkt bereits reserviert.");
            	document.getElementById("formerror").style.display = "block";
            }
            if(e.status == "407"){
            	console.log("ERREICHT : ", e.status);
            	$("#formerror").text("Sie haben nicht genügend Guthaben.");
            	document.getElementById("formerror").style.display = "block";
            }
            if(e.status == "0"){
            	console.log("ERREICHT : ", e.status);
            	$("#formerror").text("Ein Fehler ist aufgetreten. Bitte versuchen Sie es nochmal.");
            	document.getElementById("formerror").style.display = "block";
            }
        }
    });
}