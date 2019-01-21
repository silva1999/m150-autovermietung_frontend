<!-- 
/**
 * @author 	Leandro Silva
 * @date 	21.01.2019
 * @version	1.0
 * 
 * Content page, loads content inside
 */
 -->
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Content</title>
	<link rel="stylesheet" type="text/css" href="../css/style.css" />
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	<script src="../js/script.js"></script>
</head>
<body>
	<!-- Stored information -->
	<input type="hidden" id="userId" name="userIdfield"/>
	<input type="hidden" id="carId" name="carIdField"/>
	<input type="hidden" id="usernameId" name="usernameIdField"/>
	<input type="hidden" id="pageId" name="pageIdField"/>
	<!-- END Stored information -->
	
	<!-- Web page section -->
	<div class="wrapper">
	
		<!-- Header section -->
		<div class="header">
			<div class="title-container">
				<span onclick="goToOverview()" class="title">Autovermietung Zürichsee</span>
			</div>
			<div class="login-container">
				<span id="loginname" class="login-action" onclick="openLogin()">Anmelden</span>
			</div>
		</div>
		<!-- END Header section -->
		
		<!-- Main section with different content -->
		<div class="main">
			<% 
				String userId = request.getParameter("token"); 
				String carId = request.getParameter("carId"); 
				String username = request.getParameter("username"); 
				String section = request.getParameter("page");
				
				if(userId == null || userId.equals("")
						|| carId == null || carId.equals("")
						|| username == null || username.equals("")){
			%>
				<%@include  file="overview.jsp" %>
			<% } else {%>
				<script type="text/javascript">
					storeIds(<%=carId%>, '<%=userId%>', '<%=username%>', '<%=section%>');
				</script>
				<% if(section.equals("overview")){ %>
					<%@include  file="overview.jsp" %>
				<% }else{ %>
					<%@include  file="form.jsp" %>
			<% }} %>
		</div>
		<!-- END Main section -->
		
		<!-- Footer section -->
		<div class="footer">
			<span class="footer-text">Modul 150, IABM15c, Leandro Silva</span>
		</div>
		<!-- END Footer section -->
		
	</div>
	<!-- END web page section -->
	
	<!-- Login dialog -->
	<div id="logindlg" class="loginDialog">
		<h1>Anmelden</h1>
		<table>
			<tr>
				<td>Benutzername:</td>
				<td colspan="3"><input type="text" id="username"/></td>
			</tr>
			<tr>
				<td>Passwort:</td>
				<td colspan="3"><input type="password" id="pw"/></td>
			</tr>
			<tr>
				<td colspan="2"/>
				<td><button class="loginBtn" onclick="closeLogin()">Abbrechen</button></td>
				<td><button class="loginBtn" onclick="login()">Anmelden</button></td>
			</tr>
		</table>
		<div id="errorLogin"></div>
	</div>
	<!-- END Login dialog -->

</body>
</html>