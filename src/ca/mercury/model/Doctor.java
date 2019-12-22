package ca.mercury.model;

public class Doctor {
	private int cpso;
	private String fName;
	private String mName;
	private String lName;
	private String login;
	private int primaryPracticeAddress;
	private String practiceName;

	public Doctor() {
		super();
	}

	public Doctor(int cpso, String fName, String mName, String lName, String login, int primaryPracticeAddress,
			String practiceName) {
		super();
		this.cpso = cpso;
		this.fName = fName;
		this.mName = mName;
		this.lName = lName;
		this.login = login;
		this.primaryPracticeAddress = primaryPracticeAddress;
		this.practiceName = practiceName;
	}

	public int getCpso() {
		return cpso;
	}

	public void setCpso(int cpso) {
		this.cpso = cpso;
	}

	public String getfName() {
		return fName;
	}

	public void setfName(String fName) {
		this.fName = fName;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
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

	public int getPrimaryPracticeAddress() {
		return primaryPracticeAddress;
	}

	public void setPrimaryPracticeAddress(int primaryPracticeAddress) {
		this.primaryPracticeAddress = primaryPracticeAddress;
	}

	public String getPracticeName() {
		return practiceName;
	}

	public void setPracticeName(String practiceName) {
		this.practiceName = practiceName;
	}

}
