<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<title>User Profile</title>
</head>

<body>

	<sql:setDataSource var="db" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://localhost:3306/mercury" user="root" password="" />

	<sql:query dataSource="${db}" var="rs">  
SELECT distinct ohipversion FROM patients; 
</sql:query>
		<form action="${pageContext.request.contextPath}/UserController" method="post">

	<jsp:include page="header.jsp" />
	<div class="gridContainer">
		<jsp:include page="leftMenu.jsp" />
	
	
		<div id="profileBox">
		
		
			<h2 class="h2"><img src="${pageContext.request.contextPath}/img/mediIcon.png"> User Profile</h2>
			<div class="nonEditable">
				<label>Id: </label>
				<input type="text" name="userID" value="${up.username}" disabled required><span id="required" >*</span><br>
				<label>Gender: </label>			
				<c:if test="${up.gender == 'F'}">
					<input type="radio" name="gender" value="F" disabled checked><span class="genderClass">Female</span>  
					<input type="radio" name="gender" value="M" disabled ><span class="genderClass">Male</span><br>
				</c:if>
				<c:if test="${up.gender == 'M'}">
					<input type="radio" name="gender" value="F" disabled ><span class="genderClass">Female</span> 
					<input type="radio" name="gender" value="M" disabled checked><span class="genderClass">Male</span><br>
				</c:if>		
				<label>Day of Birth: </label>
				<input type="date" name="birth" value="${up.dateOfBirth}" disabled  required><span id="required">*</span><br>
				<label>OHIP Number: </label>
				<input type="text" name="ohipNum" value="${up.ohipNumber}" disabled required><span id="required">*</span>
				<input type="hidden" name="ohipNumHidden" value="${up.ohipNumber}">
				<input type="hidden" name="userIDHidden" value="${up.username}">
				<input type="hidden" name="genderHidden" value="${up.gender}">
				<input type="hidden" name="birthHidden" value="${up.dateOfBirth}">
				
			</div>
			<div class="editable">
				<label>First Name: </label>
				<input type="text" name="fName" value="${up.fName}" required><span id="required">*</span>
				<label>last Name: </label>
				<input type="text" name="lName" value="${up.lName}" required><span id="required">*</span><br>
				<label>Password: </label>
				<input type="password" name="password" value="${up.password}" required><span id="required">*</span>
				<label>OHIP Version: </label>
				<select name="ohipVer">
						<c:forEach var="item" items="${rs.rows}">
							<option value="${item.ohipversion}">${item.ohipVersion}</option>
						</c:forEach>
			    </select>
				<span id="required">*</span><br>
				
				<label>Home Number: </label>
				<input type="text" name="homeNum" maxlength="10" value="${phList[0].phoneNumber}" required><span id="required">*</span><br>
				<label>Office Number: </label>
				<input type="text" name="officeNum" maxlength="10" value="${phList[1].phoneNumber}" ><br>
				<label>Work Number: </label>
				<input type="text" name="workNum" maxlength="10" value="${phList[2].phoneNumber}" ><br>
				<label>Fax Number: </label>
				<input type="text" name="faxNum" maxlength="10" value="${phList[3].phoneNumber}" ><br>
			</div>
			<div class="divBth">
				<input id="historyBtn" class="btn" type="button" name="viewHistory" value="View Medical History">
				<input type="hidden" name="type" value="update">
				<input class="btn" type="submit" name="complete" value="profile update">
			</div>
			
			
			 
		</div>
	</div>
	
			</form>
	
	<script>
		$(document).ready(function(){
			$("#historyBtn").click(function(){
				location.href = "MedicalController?type=view";
			})
			
			
			let ohipVer = '${up.ohipVersion}';
			
		})
	</script>
</body>

</html>
