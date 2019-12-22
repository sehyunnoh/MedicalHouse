<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
<title>history page</title>
</head>

<body>

	<jsp:include page="header.jsp" />
	<div class="gridContainer">
		<jsp:include page="leftMenu.jsp" />
		<div id="historyBox">
			<h2 class="h2"><img src="${pageContext.request.contextPath}/img/mediIcon.png"> History</h2>

			<table>

				<tr>
					<td><b>Date</b></td>
					<td><b>doctor</b></td>
					<td><b>Blood Pressure Systolic</b></td>
					<td><b>Temperature</b></td>
					<td><b>Blood Pressure Diastolic</b></td>
					<td><b>Visit</b></td>
					<td><b>Reason</b></td>
					<td><b>detail</b></td>
				</tr>
				<c:forEach var="item" items="${mh}">
					<tr>
						<td>${item.date}</td>
						<td>${item.fName}</td>
						<td>${item.bloodPressureSystolic}</td>
						<td>${item.temperature}</td>
						<td>${item.bloodPressureDiastolic}</td>
						<td>${item.isVisitComplete}</td>
						<td>${item.reasonForVisit}</td>
						<td>${item.physicianNotes}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>

</body>

</html>
