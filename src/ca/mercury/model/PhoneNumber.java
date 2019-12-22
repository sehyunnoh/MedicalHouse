package ca.mercury.model;

public class PhoneNumber {

	private Long phoneNumber;
	private String userName;
	private String phoneType;

	public PhoneNumber() {
		super();
	}

	public PhoneNumber(Long phoneNumber, String userName, String phoneType) {
		super();
		this.phoneNumber = phoneNumber;
		this.userName = userName;
		this.phoneType = phoneType;
	}

	public Long getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(Long phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPhoneType() {
		return phoneType;
	}

	public void setPhoneType(String phoneType) {
		this.phoneType = phoneType;
	}

}
