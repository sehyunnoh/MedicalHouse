package ca.mercury.model;

public class MedicalHistory {

	private String fName;
	private String lName;
	private String date;
	private int bloodPressureSystolic;
	private double temperature;
	private int bloodPressureDiastolic;
	private int isVisitComplete;
	private String reasonForVisit;
	private String physicianNotes;

	public MedicalHistory(String fName, String lName, String date, int bloodPressureSystolic, double temperature,
			int bloodPressureDiastolic, int isVisitComplete, String reasonForVisit, String physicianNotes) {
		super();
		this.fName = fName;
		this.lName = lName;
		this.date = date;
		this.bloodPressureSystolic = bloodPressureSystolic;
		this.temperature = temperature;
		this.bloodPressureDiastolic = bloodPressureDiastolic;
		this.isVisitComplete = isVisitComplete;
		this.reasonForVisit = reasonForVisit;
		this.physicianNotes = physicianNotes;
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

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getBloodPressureSystolic() {
		return bloodPressureSystolic;
	}

	public void setBloodPressureSystolic(int bloodPressureSystolic) {
		this.bloodPressureSystolic = bloodPressureSystolic;
	}

	public double getTemperature() {
		return temperature;
	}

	public void setTemperature(double temperature) {
		this.temperature = temperature;
	}

	public int getBloodPressureDiastolic() {
		return bloodPressureDiastolic;
	}

	public void setBloodPressureDiastolic(int bloodPressureDiastolic) {
		this.bloodPressureDiastolic = bloodPressureDiastolic;
	}

	public int getIsVisitComplete() {
		return isVisitComplete;
	}

	public void setIsVisitComplete(int isVisitComplete) {
		this.isVisitComplete = isVisitComplete;
	}

	public String getReasonForVisit() {
		return reasonForVisit;
	}

	public void setReasonForVisit(String reasonForVisit) {
		this.reasonForVisit = reasonForVisit;
	}

	public String getPhysicianNotes() {
		return physicianNotes;
	}

	public void setPhysicianNotes(String physicianNotes) {
		this.physicianNotes = physicianNotes;
	}

}
