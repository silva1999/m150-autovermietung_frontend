<!-- 
/**
 * @author 	Leandro Silva
 * @date 	21.01.2019
 * @version	1.0
 * 
 * This is the overview section, with all cars
 */
 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="../js/script.js"></script>
</head>
<body>

	<!-- Content section -->
	<div class="overview">
	
		<!-- Car list section -->
		<div id="list">
			<input type="hidden" id="focusedCar" />
			<script type="text/javascript">
				getCars(createCarList);
			</script>
		</div>
		<!-- END Car list section -->
		
		<!-- Car details section -->
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
			<input type="hidden" id="bookCar"/>
		</div>
		<!-- END Car details section -->
		
	</div>
	<!-- END Content section -->

</body>
</html>