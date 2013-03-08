package ng.jessica.register;

import java.io.Serializable;
import java.util.ArrayList;

public class User implements Serializable {
	private String name;
	private String email;
	private ArrayList<String> courses;
	private String status;
	private String parking;
	private String hotel;
	
	public User() {
		name = "";
		email = "";
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public ArrayList<String> getCourses() {
		return (ArrayList<String>) courses;
	}
	public void setCourses(ArrayList<String> selectedCourses) {
		this.courses = selectedCourses;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getParking() {
		return parking;
	}
	public void setParking(String parking) {
		this.parking = parking;
	}
	public String getHotel() {
		return hotel;
	}
	public void setHotel(String hotel) {
		this.hotel = hotel;
	}
}
