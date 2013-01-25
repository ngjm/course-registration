package ng.jessica.hw7;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class TracksServlet
 */
public class TracksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TracksServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String errorMsgName = "";
		String errorMsgEmail = "";
		String errorMsgCourses = "";
		String errorMsgStatus = "";
		String errorMsgAddCourse = "";
		String errorMsgSendEmail = "";
		boolean error = false;

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");

		String name;
		String email;
		String[] courses;
		String status;
		String hotel;
		String parking;
		List<String> selectedCourses = new ArrayList<String>();
		List<String> updatedCourseSelection = new ArrayList<String>();
		List<String> duplicates = null;
		boolean areDuplicates = false;

		if (user == null) {
			// brand new request
			user = new User();
			name = request.getParameter("name");
			email = request.getParameter("email");
			courses = request.getParameterValues("courses");

			if (courses != null) {
				for (int i = 0; i < courses.length; i++) {
					selectedCourses.add(courses[i]);
				}
			}
			status = request.getParameter("status");
			System.out.println("status gotten is " + status);
			hotel = request.getParameter("hotel");
			parking = request.getParameter("parking");

			user.setName(name);
			user.setEmail(email);
			user.setCourses((ArrayList<String>) selectedCourses);
			user.setStatus(status);
			user.setHotel(hotel);
			user.setParking(parking);
		} else {
			// adding new courses
			courses = request.getParameterValues("courses");
			if (courses != null) {
				for (int i = 0; i < courses.length; i++) {
					updatedCourseSelection.add(courses[i]);
				}
			}

			selectedCourses = (ArrayList<String>) session
					.getAttribute("courses");
			updatedCourseSelection.addAll(selectedCourses);

			duplicates = findDuplicates(updatedCourseSelection);
			if (duplicates.size() > 0) {
				areDuplicates = true;
			} else {
				selectedCourses = updatedCourseSelection;
				user.setCourses((ArrayList<String>) selectedCourses);
			}
		}

		String action = request.getParameter("action");
		String indexToRemove = request.getParameter("indexToRemove");
		if (action != null && action.equals("DELETE")) {
			selectedCourses = (ArrayList<String>) session
					.getAttribute("courses");
			selectedCourses.remove(Integer.parseInt(indexToRemove));
			user.setCourses((ArrayList<String>) selectedCourses);
		}

		if (user != null && user.getName().length() < 1) {
			errorMsgName = "Please enter your name.";
			error = true;
		}
		if (user != null && user.getEmail().length() < 1) {
			errorMsgEmail = "Please enter your e-mail.";
			error = true;
		}
		if (user != null && user.getCourses() == null) {
			errorMsgCourses = "Please select 1 or more courses.";
			error = true;
		}
		if (user != null && user.getStatus() == null) {
			errorMsgStatus = "Please select a status.";
			error = true;
		}

		if (areDuplicates) {
			for (int i = 0; i < duplicates.size(); i++) {
				errorMsgAddCourse += "\nError - You have already added "
						+ duplicates.get(i) + " to your schedule.";
			}
		}

		String url = "";
		if (error) {
			url = "/index.jsp";
		} else if (action != null && action.equals("CONFIRM")) {
			url = "/payment.jsp";
		} else if (action != null && action.equals("EMAIL")) {
			/*
			 * int courseCost = 0; int total = 0; int hotelFee = 185; int
			 * parkingFee = 10;
			 * 
			 * if (user.getStatus() != null) { if
			 * (user.getStatus().equals("JHU Employee")) { courseCost = 850; }
			 * else if (user.getStatus().equals("JHU Student")) { courseCost =
			 * 1000; } else if (user.getStatus().equals("Speaker")) { courseCost
			 * = 0; } else { courseCost = 1350; } }
			 * 
			 * String to = user.getEmail(); String from = "noreply@jhu.edu";
			 * String subject =
			 * "Annual JHU Software Development Seminar Registration Confirmation"
			 * ; String body = user.getName() + ", <br />" +
			 * "Thank you for registering your participation in the Annual Johns Hopkins "
			 * +
			 * "Software Development Seminar. Below is your registration information: <br /> <table>"
			 * ; int numOfCourses = user.getCourses().size(); for (int i = 0; i
			 * < numOfCourses; i++) { body += "<tr><td>" +
			 * user.getCourses().get(i) + "</td><td>$" + courseCost +
			 * ".00</td></tr>"; } total = numOfCourses * courseCost; if
			 * (user.getHotel() != null) { body +=
			 * "<tr><td>Hotel Accommodation</td><td>$" + hotelFee +
			 * ".00</td></tr>"; total += hotelFee; }
			 * 
			 * if (user.getParking() != null) { body +=
			 * "<tr><td>Parking Permit</td><td>$" + parkingFee +
			 * ".00</td></tr>"; total += parkingFee; } body +=
			 * "<tr><td align=right>Total</td><td>" + total +
			 * ".00</td></tr></table><br />"; body += "Thank you."; boolean
			 * isBodyHTML = true;
			 * 
			 * try { MailUtilLocal.sendMail(to, from, subject, body,
			 * isBodyHTML); } catch (MessagingException e) { errorMsgSendEmail =
			 * "Unable to send confirmation e-mail at this time. Please try again later."
			 * ; }
			 */
			
			url = "/confirmation.jsp";
		} else if (action != null && action.equals("DELETE")) {
			url = "/results.jsp";
		} else if (action != null && action.equals("ADD")) {
			url = "/courses.jsp";
		} else if (areDuplicates) {
			url = "/courses.jsp";
		} else {
			url = "/results.jsp";
		}

		session.setAttribute("msgName", errorMsgName);
		session.setAttribute("msgEmail", errorMsgEmail);
		session.setAttribute("msgCourses", errorMsgCourses);
		session.setAttribute("msgStatus", errorMsgStatus);

		session.setAttribute("msgDuplicateCourse", errorMsgAddCourse);

		session.setAttribute("msgSendEmail", errorMsgSendEmail);

		session.setAttribute("user", user);
		session.setAttribute("courses", selectedCourses);

		RequestDispatcher dispatcher = getServletContext()
				.getRequestDispatcher(url);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

	public static List<String> findDuplicates(List<String> selectedCourses) {

		Map<String, String> repeated = new HashMap<String, String>();
		Iterator<String> iterator = selectedCourses.iterator();

		List<String> duplicates = new ArrayList<String>();

		while (iterator.hasNext()) {
			String str = (String) iterator.next();

			if (repeated.containsKey(str)) {
				duplicates.add(str);
			} else {
				repeated.put(str, "1");
			}
		}
		return duplicates;
	}

}
