package ca.mercury.model;

public class SessionUserInfo {

	private String userName;
	private int role;
	private String fName;
	private String lName;

	public SessionUserInfo(String userName, int role, String fName, String lName) {
		super();
		this.userName = userName;
		this.role = role;
		this.fName = fName;
		this.lName = lName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public int getRole() {
		return role;
	}

	public void setRole(int role) {
		this.role = role;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getlName() {
		return lName;
	}

	public void setlName(String lName) {
		this.lName = lName;
	}

}
