package ca.mercury.common;

public class DateCommon {

	public static String addDash(String date) {
		return date.substring(0, 4)+"-"+date.substring(4, 6)+"-"+date.substring(6, 8);
	}
}
