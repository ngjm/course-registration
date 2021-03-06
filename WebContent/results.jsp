<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>Review Selections</title>
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
	<br /> Your confirmation will be sent to:
	<font style="font-weight: bold"><a href="mailto:<%=user.getEmail()%>"><%=user.getEmail()%></a></font>


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
	%>

	<br />
	<br />
	<div id="summary">
	<table colspan="4" border="0" width="85%">

		<tr>
			<td align="center"><font style="font-weight: bold">Your
					Courses</font></td>
			<td />
			<td align="center"><font style="font-weight: bold">Cost</font></td>
			<td />
		</tr>

		<%
			if (selectedCourses != null) {
				for (int i = 0; i < selectedCourses.size(); i++) {
		%>
		<tr>
			<td><%=selectedCourses.get(i)%></td>
			<td />
			<td>$ <%=courseCost%>.00
			</td>
			<td>
				<form name="deleteCourse" action="/registration/TracksServlet" method="POST">			
					<input type="hidden" name="action" value="DELETE" />
					<input type="hidden" name="indexToRemove" value="<%= i %>" />
					<input type="hidden" name="name" value="<%= user.getName()  %>" />
					<input type="hidden" name="email" value="<%= user.getEmail() %>" />
					<input type="hidden" name="status" value="<%= user.getStatus() %>" />
					<input type="submit" value="Remove"/>
				</form>
			</td>
		</tr>
		<tr />
		<%
			}
				total = courseCost * selectedCourses.size();
			}
		%>

		<%
			if (user.getHotel() != null) {
				total += hotelFee;
		%>
		<tr>
			<td>Hotel Accommodation</td>
			<td />
			<td>$ <%=hotelFee%>.00
			</td>
		</tr>
		<%
			}
		%>

		<%
			if (user.getParking() != null) {
				total += parkingFee;
		%>
		<tr>
			<td>Parking Permit</td>
			<td />
			<td>$ <%=parkingFee%>.00
			</td>
		</tr>
		<%
			}
		%>

		<tr>
			<td />
			<td id="totalLabel"><font style="font-weight: bold">TOTAL</font></td>
			<td id="totalAmount">$ <%=total%>.00
			</td>
		</tr>
	</table>
	</div>
	
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
		<input type="hidden" name="action" value="CONFIRM">
		<input type="hidden" name="name" value="<%= user.getName() %>">
		<input type="hidden" name="email" value="<%= user.getEmail() %>">
		<input type="hidden" name="status" value="<%= user.getStatus() %>">
	</form>
	</div>
	</div>
</div>
</body>
</html>