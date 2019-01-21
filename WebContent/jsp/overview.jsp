<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="../js/script.js"></script>
	<script type="text/javascript">
	//https://stackoverflow.com/questions/14220321/how-do-i-return-the-response-from-an-asynchronous-call
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
	function getCarById(id, callback){
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
	</script>
</head>
<body>
	<div class="overview">
		<div id="list">
			<script type="text/javascript">
			function createCarList(apiresponse, onClickFunction){
				var data = apiresponse;
				var carlist = document.getElementById("list");
				for(var i = 0; i < data.length; i++){
					var divitem = document.createElement("div");
					divitem.className = "item";
					var carId = data[i].id;
					//https://stackoverflow.com/questions/30476721/passing-parameter-onclick-in-a-loop
					divitem.onclick = (function (carId, showDetails) {
						return function(){
							getCarById(carId, showDetails);
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
			getCars(createCarList);
			</script>
		</div>
		<div id="detailWindow" class="details">
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
			<button id="detailBtn" class="rentCarBtn" onclick="goToForm()">Zeitpunkt definieren</button>
		</div>
	</div>

</body>
</html>