<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.util.List"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	<font style="font-weight: bold"><%=user.getEmail()%></font>


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

	<table colspan="3" border="0" width="70%">

		<tr>
			<td align="center"><font style="font-weight: bold">Your
					Courses</font></td>
			<td />
			<td align="center"><font style="font-weight: bold">Cost</font></td>
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
				<form name="deleteCourse" action="/hw7/TracksServlet" method="POST">			
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
			<td><font style="font-weight: bold">Total</font></td>
			<td>$ <%=total%>.00
			</td>
		</tr>
	</table>
	

	<input type="button" value="Edit Information" />
	
	<form name="addCourses" action="/hw7/TracksServlet" method="POST">
		<input type="submit" value="Add More Courses" />
		<input type="hidden" name="action" value="ADD">
		<input type="hidden" name="name" value="<%= user.getName() %>">
		<input type="hidden" name="email" value="<%= user.getEmail() %>">
		<input type="hidden" name="status" value="<%= user.getStatus() %>">
	</form>

	
	<form name="emailConfirm" action="/hw7/TracksServlet" method="POST">
		<input type="submit" value="Confirm Registration" />
		<input type="hidden" name="action" value="CONFIRM">
		<input type="hidden" name="name" value="<%= user.getName() %>">
		<input type="hidden" name="email" value="<%= user.getEmail() %>">
		<input type="hidden" name="status" value="<%= user.getStatus() %>">
	</form>
		

</body>
</html>