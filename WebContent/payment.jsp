<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Payment Information</title>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="css/styles.css"/>
	</head>
<body>
	<%@ page import="ng.jessica.register.User"%>
	<%@ page import="java.util.ArrayList"%>
	
<div class="formBody">
	<div id="title"><h2>ANNUAL SOFTWARE DEVELOPMENT SEMINAR</h2></div>

	<%
		User user = (User) session.getAttribute("user");
		if (user == null) {
			user = new User();
		}

		ArrayList<String> selectedCourses = (ArrayList<String>) session
				.getAttribute("courses");

		if ((selectedCourses != null) && (selectedCourses.size() > 0)) {
			selectedCourses = user.getCourses();
			session.setAttribute("courses", selectedCourses);
		}
		session.setAttribute("courses", selectedCourses);

		String msgSendEmail = (String) session
				.getAttribute("errorMsgSendEmail");

		// handle null values
		if (msgSendEmail == null)
			msgSendEmail = "";
	%>

	<%!int courseCost = 0;%>
	<%!int totalCourseCost = 0;%>
	<%!int hotelFee = 185;%>
	<%!int parkingFee = 10;%>
	<%!int total = 0;%>

	<font style="font-weight: bold"><%=user.getName()%></font>
	<br />
	<br /> You are registered as a
	<font style="font-weight: bold"><%=user.getStatus()%></font>.
	<br />

	<%
		if (user.getStatus() != null) {
			if (user.getStatus().equals("JHU Employee")) {
				courseCost = 850;
			} else if (user.getStatus().equals("JHU Student")) {
				courseCost = 1000;
			} else if (user.getStatus().equals("Speaker")) {
				courseCost = 0;
			} else {
				courseCost = 1350;
			}
		}

		if (selectedCourses != null) {
			total = courseCost * selectedCourses.size();
		}
		if (user.getHotel() != null) {
			total += hotelFee;
		}
		if (user.getParking() != null) {
			total += parkingFee;
		}
	%>

	<br /> Your total cost for the seminar is:
	<font style="font-weight: bold">$<%=total%>.00
	</font>

	<br />

	<fieldset id="paymentDetails">
		<legend>Payment Details</legend>

		<table>
			<tr>
				<td>Credit Card Type</td>
				<td><input type="radio" name="ccType" value="visa" />VISA <input
					type="radio" name="ccType" value="mastercard" />Master Card <input
					type="radio" name="ccType" value="discover" />Discover</td>
			</tr>
			<tr>
				<td>Credit Card Number</td>
				<td><input type="text" /></td>
			</tr>
			<tr>
				<td>Credit Card Expiration</td>
				<td><input type="text" /></td>
			</tr>

		</table>
	</fieldset>

	<div class="submitButtons">
	
	<div class="button">
		<input type="button" value="Edit Information" />
	</div>
	
	<div class="button">
	<form name="addCourses" action="/registration/TracksServlet" method="POST">
		<input type="submit" value="Add More Courses" />
		<input type="hidden" name="action" value="ADD">
		<input type="hidden" name="name" value="<%= user.getName() %>">
		<input type="hidden" name="email" value="<%= user.getEmail() %>">
		<input type="hidden" name="status" value="<%= user.getStatus() %>">
	</form>
	</div>

	<div class="button">
	<form name="emailConfirm" action="/registration/TracksServlet" method="POST">
		<input type="submit" value="Confirm Registration" />
		<input type="hidden" name="action" value="EMAIL">
		<input type="hidden" name="name" value="<%= user.getName() %>">
		<input type="hidden" name="email" value="<%= user.getEmail() %>">
		<input type="hidden" name="status" value="<%= user.getStatus() %>">
	</form>
	</div>
	
	</div>
	
</div>
</body>
</html>