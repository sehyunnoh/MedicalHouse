package ca.mercury.model;

public class Patient {

	private long ohipNumber;
	private String ohipVersion;
	private String fName;
	private String lName;
	private String login;
	private String gender;
	private String dateOfBirth;

	public Patient() {
		super();
	}

	public Patient(long ohipNumber, String ohipVersion, String fName, String lName, String login, String gender,
			String dateOfBirth) {
		super();
		this.ohipNumber = ohipNumber;
		this.ohipVersion = ohipVersion;
		this.fName = fName;
		this.lName = lName;
		this.login = login;
		this.gender = gender;
		this.dateOfBirth = dateOfBirth;
	}
	public Patient(long ohipNumber, String ohipVersion, String fName, String lName) {
		super();
		this.ohipNumber = ohipNumber;
		this.ohipVersion = ohipVersion;
		this.fName = fName;
		this.lName = lName;
	}

	public long getOhipNumber() {
		return ohipNumber;
	}

	public void setOhipNumber(int ohipNumber) {
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

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
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
