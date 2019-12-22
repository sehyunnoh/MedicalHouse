package ca.mercury.model;

public class Appointment {
	private long appNumber;
	private long patient; // ohip number
	private String reasonForVisit;
	private String date;
	private String time;
	private int isPatientCheckedIn;

	public Appointment() {
		super();
	}

	public Appointment(long appNumber, long patient, String reasonForVisit, String date, String time,
			int isPatientCheckedIn) {
		super();
		this.appNumber = appNumber;
		this.patient = patient;
		this.reasonForVisit = reasonForVisit;
		this.date = date;
		this.time = time;
		this.isPatientCheckedIn = isPatientCheckedIn;
	}

	public long getAppNumber() {
		return appNumber;
	}

	public void setAppNumber(long appNumber) {
		this.appNumber = appNumber;
	}

	public long getPatient() {
		return patient;
	}

	public void setPatient(long patient) {
		this.patient = patient;
	}

	public String getReasonForVisit() {
		return reasonForVisit;
	}

	public void setReasonForVisit(String reasonForVisit) {
		this.reasonForVisit = reasonForVisit;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getIsPatientCheckedIn() {
		return isPatientCheckedIn;
	}

	public void setIsPatientCheckedIn(int isPatientCheckedIn) {
		this.isPatientCheckedIn = isPatientCheckedIn;
	}

}
