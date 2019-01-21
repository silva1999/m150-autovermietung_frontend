<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Rent car</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="../js/script.js"></script>
	<script type="text/javascript">
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
	</script>
</head>
<body>
	<script type="text/javascript">
		getCarById(initializeForm);
	</script>
	
	<div class="formbody">
		<div id="picture" class="picture">
			
		</div>
		<div class="cardetails">
			<h2 class="detailstitle">Details</h2>
			<table class="carInfoTable">
				<tr>
					<td class="itemlabel">Marke: </td>
					<td id="detailName" class="itemvalue">BMW</td>
				</tr>
				<tr>
					<td class="itemlabel">Model: </td>
					<td id="detailSpecification" class="itemvalue">335i</td>
				</tr>
				<tr>
					<td class="itemlabel">Ort: </td>
					<td id="detailPlace" class="itemvalue">Zürich</td>
				</tr>
				<tr>
					<td class="space"></td>
					<td class="space"></td>
				</tr>
				<tr>
					<td class="itemlabel">Preis pro Stunde: </td>
					<td id="detailPrice" class="itemvalue">100 CHF</td>
				</tr>
			</table>
		</div>
		<div class="rentform">
			<table>
				<tr>
					<td colspan="2">Zeitpunkt festlegen</td>
					<td colspan="2"></td>
				</tr>
				<tr>
					<td>Von: </td>
					<td> <input id="startDate" class="dateinput" type="text"/> </td>
					<td>Bis: </td>
					<td> <input id="endDate" class="dateinput" type="text"/> </td>
				</tr>
				<tr>
					<td colspan="4"><button class="rentbutton" onclick="rentCar()">Mieten</button></td>
				</tr>
			</table>
		</div>
		<div id="formerror" class="errormsg">
		
		</div>
		<div id="successmsg" class="loginDialog">
			<h1 class="successtitle">Mietantrag erfolgreich</h1>
			<p class="infotext">Der Mietantrag wurde erfolgreich erstellt. Sie werden von uns für das weitere Vorgehen per SMS kontaktiert.</p>
			<button class="acceptBtn" onclick="goToOverview()">OK</button>
		</div>
	</div>

</body>
</html>