<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.Date"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<title>Appointment page</title>

</head>

<body>
	<div class="bigBox"></div>
	<div id="createBox">
		<h2><img src="${pageContext.request.contextPath}/img/mediIcon.png"> create</h2>
		<form action="CalendarController" method="post">
			<input type="hidden" name="type" value="create"> 
			<label>date: </label> <input id="theDate" type="date" name="date" required><br>
			<label>time: </label> <input id="theTime" type="time" name="time" required><br> 
			<label>reason: </label> <input type="text" name="reason" placeholder="reason" required><br>
			<input id="createBtn1" type="submit" value="create" name="ptype">
			<input id="cancel" type="button" value="cancel" name="cancel">
		</form>
	</div>
	
	<jsp:include page="header.jsp" />
	<div class="gridContainer">
		<jsp:include page="leftMenu.jsp" />
		<div id="appointBox">
			<h2><img src="${pageContext.request.contextPath}/img/mediIcon.png"> Appointment <input type="button" name="create" value="Create" id="createBtn"></h2>
			<ul id="todayBox">
				<li><h3>Today</h3></li>
				<c:forEach var="item" items="${day1List}">
					<li><p class="todayList">
						<b>${item.date}</b><span> | ${item.reasonForVisit}</span>
						<input class="inputChebox" type="checkbox"
						<c:if test = "${item.isPatientCheckedIn == '1'}">
		           		<c:out value="checked" />
		        		</c:if>><span class="registeredBox"></span>
						</p>
					</li>
				</c:forEach>
			</ul>
			<br>
			<h3>Upcoming Appointments</h3>
			<table>
				<tr>
					<c:set var="day1" value="<%=new Date()%>" />
					<c:set var="day2"
						value="<%=new Date(new Date().getTime() + 60 * 60 * 24 * 1000)%>" />
					<c:set var="day3"
						value="<%=new Date(new Date().getTime() + 60 * 60 * 24 * 1000 * 2)%>" />
					<c:set var="day4"
						value="<%=new Date(new Date().getTime() + 60 * 60 * 24 * 1000 * 3)%>" />
					<c:set var="day5"
						value="<%=new Date(new Date().getTime() + 60 * 60 * 24 * 1000 * 4)%>" />
					<c:set var="day6"
						value="<%=new Date(new Date().getTime() + 60 * 60 * 24 * 1000 * 5)%>" />
					<c:set var="day7"
						value="<%=new Date(new Date().getTime() + 60 * 60 * 24 * 1000 * 6)%>" />

					<td><b><fmt:formatDate type="date" value="${day1}" pattern="yyyy-MM-dd" /></b></td>
					<td><b><fmt:formatDate type="date" value="${day2}" pattern="yyyy-MM-dd" /></b></td>
					<td><b><fmt:formatDate type="date" value="${day3}" pattern="yyyy-MM-dd" /></b></td>
					<td><b><fmt:formatDate type="date" value="${day4}" pattern="yyyy-MM-dd" /></b></td>
					<td><b><fmt:formatDate type="date" value="${day5}" pattern="yyyy-MM-dd" /></b></td>
					<td><b><fmt:formatDate type="date" value="${day6}" pattern="yyyy-MM-dd" /></b></td>
					<td><b><fmt:formatDate type="date" value="${day7}" pattern="yyyy-MM-dd" /></b></td>
				</tr>
				<tr>
					<td><c:forEach var="item" items="${day1List}">
							${item.reasonForVisit}<br>${item.time} <br>							
							<input class="cancleBtn" id="${item.appNumber}" type="button" value="Cancel" name="cancel"> <br>
						</c:forEach></td>
					<td><c:forEach var="item" items="${day2List}">
							${item.reasonForVisit}<br> ${item.time} <br>							
							<input class="cancleBtn" id="${item.appNumber}" type="button" value="Cancel" name="cancel"> <br>
						</c:forEach></td>
					<td><c:forEach var="item" items="${day3List}">
							${item.reasonForVisit}<br> ${item.time} <br>							
							<input class="cancleBtn" id="${item.appNumber}" type="button" value="Cancel" name="cancel"> <br>
						</c:forEach></td>
					<td><c:forEach var="item" items="${day4List}">
							${item.reasonForVisit}<br> ${item.time} <br>							
							<input class="cancleBtn" id="${item.appNumber}" type="button" value="Cancel" name="cancel"> <br>
						</c:forEach></td>
					<td><c:forEach var="item" items="${day5List}">
							${item.reasonForVisit}<br> ${item.time} <br>							
							<input class="cancleBtn" id="${item.appNumber}" type="button" value="Cancel" name="cancel"> <br>
						</c:forEach>
					</td>
					<td><c:forEach var="item" items="${day6List}">
							${item.reasonForVisit}<br> ${item.time} <br>							
							<input class="cancleBtn" id="${item.appNumber}" type="button" value="Cancel" name="cancel"> <br>
						</c:forEach>
					</td>
					<td><c:forEach var="item" items="${day7List}">
							${item.reasonForVisit}<br> ${item.time} <br>							
							<input class="cancleBtn" id="${item.appNumber}" type="button" value="Cancel" name="cancel"> <br>
						</c:forEach>
					</td>
				</tr>
			</table>
		</div>
	</div>
	
	<script>
	$(document).ready(function() {
		
		$("#createBtn").click(function() {
			$("#createBox").show();
			$(".bigBox").addClass("visiable");
		});
		
		$("#cancel").click(function(){
			$(".bigBox").removeClass("visiable");
			$("#createBox").hide();
		});
	
		var date = new Date();
	
		var day = date.getDate();
		var month = date.getMonth() + 1;
		var year = date.getFullYear();
	
		if (month < 10)
			month = "0" + month;
		if (day < 10)
			day = "0" + day;
	
		var today = year + "-" + month + "-" + day;
		$("#theDate").attr("value", today);
	
		$("#theTime").val("12:00");
	
		$(".cancleBtn").click(function() {
	
			var appNum = this.id;
	
			if (confirm("cancel?")) {
				location.href = "CalendarController?ptype=cancel&&appNumber=" + appNum;
			}
		})
		
		
	
	});
	</script>


</body>

</html>