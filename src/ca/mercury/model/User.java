package ca.mercury.model;

public class User {
	private String username;
	private int role;
	private String password;
	private String date;

	public User() {
		super();
	}

	public User(String username, int role, String password, String date) {
		super();
		this.username = username;
		this.role = role;
		this.password = password;
		this.date = date;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

}
