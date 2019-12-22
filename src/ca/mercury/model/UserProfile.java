package ca.mercury.model;

public class UserProfile {

	private String username;
	private String password;
	private long ohipNumber;
	private String ohipVersion;
	private String fName;
	private String lName;
	private String gender;
	private String dateOfBirth;
	public UserProfile(String username, String password, long ohipNumber, String ohipVersion, String fName,
			String lName, String gender, String dateOfBirth) {
		super();
		this.username = username;
		this.password = password;
		this.ohipNumber = ohipNumber;
		this.ohipVersion = ohipVersion;
		this.fName = fName;
		this.lName = lName;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public long getOhipNumber() {
		return ohipNumber;
	}
	public void setOhipNumber(long ohipNumber) {
		this.ohipNumber = ohipNumber;
	}
	public String getOhipVersion() {
		return ohipVersion;
	}
	public void setOhipVersion(String ohipVersion) {
		this.ohipVersion = ohipVersion;
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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	
	
	
	
	
}
