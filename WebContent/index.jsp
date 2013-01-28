<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Seminar Registration</title>
		<link rel="stylesheet" type="text/css" href="css/styles.css"/>
	</head>

<body>
	<%@ page import="ng.jessica.hw7.User"%>
	<%@ page import="java.util.ArrayList"%>
<div class="formBody">
	<div id="title"><h2>ANNUAL SOFTWARE DEVELOPMENT SEMINAR</h2></div>

	<%
		User user = (User) session.getAttribute("user");
		if (user == null) {
			user = new User();
		}

		String msgName = (String) session.getAttribute("msgName");
		String msgEmail = (String) session.getAttribute("msgEmail");
		String msgCourses = (String) session.getAttribute("msgCourses");
		String msgStatus = (String) session.getAttribute("msgStatus");

		// handle null values
		if (msgName == null)
			msgName = "";
		if (msgEmail == null)
			msgEmail = "";
		if (msgCourses == null)
			msgCourses = "";
		if (msgStatus == null)
			msgStatus = "";
		
		if (msgName.length() > 0  || msgEmail.length() > 0|| msgCourses.length() > 0 || msgStatus.length() > 0) {
			user = new User();
		}
	%>

	<form name="reservationForm" action="/registration/TracksServlet" method="get">
	<fieldset>
		<legend>Contact Information</legend>
		<table>
			<tr>
				<td>Name:</td>
				<td><input type="text" name="name"></td>
				<td><font style="color: red"><%=msgName%></font></td>
			</tr>
			<tr>
				<td>E-mail:</td>
				<td><input type="text" name="email"></td>
				<td><font style="color: red"><%=msgEmail%></font></td>

			</tr>
		</table>
	</fieldset>
	
	<fieldset>
		<legend>Select Your Courses</legend>
		<table>
			<tr>
				<td><select name="courses" size="7" multiple="multiple">
						<option value="A4 - Web Services">A4 - Web Services</option>
						<option value="A1 - J2EE Design Patterns">A1 - J2EE
							Design Patterns</option>
						<option value="A3 - Service Oriented Architectures">A3 -
							Service Oriented Architectures</option>
						<option value="A4 - Enterprise Service Bus">A4 -
							Enterprise Service Bus</option>
						<option value="A6 - Secure Messaging">A6 - Secure
							Messaging</option>
						<option value="A5 - Web Services Security">A5 - Web
							Services Security</option>
				</select></td>
				<td><div style="padding-left: 2em">
						<font style="color: red"><%=msgCourses%></font>
					</div></td>
			</tr>
		</table>
	</fieldset>

	<fieldset>
		<legend>Employment Status</legend>
		<table>
			<tr>
				<td><input type="radio" name="status" value="JHU Employee" />JHU
					Employee<br /> <input type="radio" name="status"
					value="JHU Student" />JHU Student<br /> <input type="radio"
					name="status" value="Speaker" />Speaker<br /> <input type="radio"
					name="status" value="Other" />Other<br /></td>
				<td><div style="padding-left: 2em">
						<font style="color: red"><%=msgStatus%></font>
					</div></td>
			</tr>
		</table>
	</fieldset>
	
	<fieldset>
		<legend>Additional Fees and Charges</legend>
		<input type="checkbox" name="hotel" value="hotel" />Hotel
		Accommodation (Conference Guest Special Fee - Parking Included) <br />
		<input type="checkbox" name="parking" value="parking" />Parking
		Permit
	</fieldset>
	
	<div class="submitButtons">
		<input type="submit" value="Compute Seminar Costs" />
	</div>
	</form>
	</div>
</body>

</html>