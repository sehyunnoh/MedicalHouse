package ca.mercury.model;

public class Visit {
	private int visitNumber;
	private int physician;
	private String date;
	private int bloodPressureSystolic;
	private double temperature;
	private int bloodPressureDiastolic;
	private int isVisitComplete;
	private String medicalDiagnosis;
	private String physicianNotes;
	private int appointment;

	public Visit() {
		super();
	}

	public Visit(int visitNumber, int physician, String date, int bloodPressureSystolic, double temperature,
			int bloodPressureDiastolic, int isVisitComplete, String medicalDiagnosis, String physicianNotes,
			int appointment) {
		super();
		this.visitNumber = visitNumber;
		this.physician = physician;
		this.date = date;
		this.bloodPressureSystolic = bloodPressureSystolic;
		this.temperature = temperature;
		this.bloodPressureDiastolic = bloodPressureDiastolic;
		this.isVisitComplete = isVisitComplete;
		this.medicalDiagnosis = medicalDiagnosis;
		this.physicianNotes = physicianNotes;
		this.appointment = appointment;
	}

	public int getVisitNumber() {
		return visitNumber;
	}

	public void setVisitNumber(int visitNumber) {
		this.visitNumber = visitNumber;
	}

	public int getPhysician() {
		return physician;
	}

	public void setPhysician(int physician) {
		this.physician = physician;
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

	public String getMedicalDiagnosis() {
		return medicalDiagnosis;
	}

	public void setMedicalDiagnosis(String medicalDiagnosis) {
		this.medicalDiagnosis = medicalDiagnosis;
	}

	public String getPhysicianNotes() {
		return physicianNotes;
	}

	public void setPhysicianNotes(String physicianNotes) {
		this.physicianNotes = physicianNotes;
	}

	public int getAppointment() {
		return appointment;
	}

	public void setAppointment(int appointment) {
		this.appointment = appointment;
	}

}
