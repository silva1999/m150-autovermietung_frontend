<!-- 
/**
 * @author 	Leandro Silva
 * @date 	21.01.2019
 * @version	1.0
 * 
 * This is a section with a form, to book a car
 */
 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Rent car</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="../js/script.js"></script>
</head>
<body>
	<!-- Load data section -->
	<script type="text/javascript">
		getCarById(initializeForm);
	</script>
	<!-- END Load data section -->
	
	<!-- Content -->
	<div class="formbody">
	
		<!-- Car image -->
		<div id="picture" class="picture">
		</div>
		
		<!-- Car details -->
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
		<!-- END Car details -->
		
		<!-- Book car form -->
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
		<!-- END Book car form -->
		
		<!-- Messages section -->
		<div id="formerror" class="errormsg">
		</div>
		<div id="successmsg" class="loginDialog">
			<h1 class="successtitle">Mietantrag erfolgreich</h1>
			<p class="infotext">Der Mietantrag wurde erfolgreich erstellt. Sie werden von uns für das weitere Vorgehen per SMS kontaktiert.</p>
			<button class="acceptBtn" onclick="goToOverview()">OK</button>
		</div>
		<!-- END Messages section -->
		
	</div>
	<!-- END content -->

</body>
</html>