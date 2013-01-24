<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>HW 7</title>

</head>

<body>
	<%@ page import="ng.jessica.hw7.User"%>
	<%@ page import="java.util.ArrayList"%>

	<h1>JOHNS HOPKINS ANNUAL SOFTWARE DEVELOPMENT SEMINAR</h1>
	<br />

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
	%>

	<form name="reservationForm" action="/hw7/TracksServlet" method="get">
		<h3>Contact Information</h3>
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

		<br />

		<h3>Select Your Courses</h3>


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

		<h3>Employment Status</h3>


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

		<br />

		<h3>Additional Fees and Charges</h3>
		<input type="checkbox" name="hotel" value="hotel" />Hotel
		Accommodation (Conference Guest Special Fee - Parking Included) <br />
		<input type="checkbox" name="parking" value="parking" />Parking
		Permit <br /> <br /> <input type="submit"
			value="Compute Seminar Costs" />
	</form>
</body>

</html>