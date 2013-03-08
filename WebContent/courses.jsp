<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Course Selection</title>
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

		String msgDuplicateCourse = (String) session
				.getAttribute("msgDuplicateCourse");

		// handle null values
		if (msgDuplicateCourse == null)
			msgDuplicateCourse = "";
	%>

	<form name="reservationForm" action="/registration/TracksServlet" method="get">

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
						<font style="color: red"><%=msgDuplicateCourse%></font>
					</div></td>
			</tr>
		</table>

		<br /> <input type="submit" value="Compute Seminar Costs" />
	</form>
	</div>
</body>

</html>