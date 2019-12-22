package ca.mercury.model;

public class Address {

	private int addressId;
	private String streeLine1;
	private String streetLine2;
	private String aptOrUnitNumber;
	private String city;
	private String province;
	private String postalCode;
	private String type;
	private String occupant;

	public Address() {
		super();
	}

	public Address(int addressId, String streeLine1, String streetLine2, String aptOrUnitNumber, String city,
			String province, String postalCode, String type, String occupant) {
		super();
		this.addressId = addressId;
		this.streeLine1 = streeLine1;
		this.streetLine2 = streetLine2;
		this.aptOrUnitNumber = aptOrUnitNumber;
		this.city = city;
		this.province = province;
		this.postalCode = postalCode;
		this.type = type;
		this.occupant = occupant;
	}

	public int getAddressId() {
		return addressId;
	}

	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}

	public String getStreeLine1() {
		return streeLine1;
	}

	public void setStreeLine1(String streeLine1) {
		this.streeLine1 = streeLine1;
	}

	public String getStreetLine2() {
		return streetLine2;
	}

	public void setStreetLine2(String streetLine2) {
		this.streetLine2 = streetLine2;
	}

	public String getAptOrUnitNumber() {
		return aptOrUnitNumber;
	}

	public void setAptOrUnitNumber(String aptOrUnitNumber) {
		this.aptOrUnitNumber = aptOrUnitNumber;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getOccupant() {
		return occupant;
	}

	public void setOccupant(String occupant) {
		this.occupant = occupant;
	}

}
