<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/style.css">
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

		<div class="createProfileBox">
			<div id="profileBox">
				<h2 class="h2"><img src="${pageContext.request.contextPath}/img/mediIcon.png"> Create Profile</h2>
				<div class="nonEditable">
					<label>ID: </label> <input id="username" type="text" name="userID" required><span id="required">*</span>
					<button id="dupCheck" type="button">dup check</button>

					<br> <label>Gender: </label> 
					
					<input type="radio" name="gender" value="F" checked><span class="genderClass">Female</span>
					<input type="radio" name="gender" value="M"><span class="genderClass">Male</span><br>
					<label>Day of Birth: </label> <input type="date" name=birth required><span id="required">*</span><br> 
					<label>OHIP Number: </label> <input type="text" name="ohipNum" maxlength="10" required> <span id="required">*</span>
				</div>
				<div class="editable">
					<label>First Name: </label> <input type="text" name="fName" required><span id="required">*</span> 
					<label>Last Name: </label> <input type="text" name="lName" required><span id="required">*</span><br> 
					<label>Password: </label> <input type="password" name="password" required><span id="required">*</span> <label>OHIP Version: </label>
					<select name="ohipVer">
						<c:forEach var="item" items="${rs.rows}">
							<option value="${item.ohipversion}">${item.ohipversion}</option>
						</c:forEach>
					</select> <span id="required">*</span><br> 
					<label>Home Number: </label> <input type="text" maxlength="10" name="homeNum" required><span id="required">*</span><br> 
					<label>Office Number: </label> <input type="text" maxlength="10" name="officeNum"><br> 
					<label>Work Number: </label> <input type="text" maxlength="10" name="workNum"><br> 
					<label>Fax Number: </label> <input type="text" maxlength="10" name="faxNum"><br>
				</div>
				<div class="divBth">
					<input type="hidden" name="type" value="create"> 
					<input class="btn" type="submit" name="create" value="create">
				</div>

			</div>
		</div>
	</form>

	<script>
	
		var checkUser = '${checkUser}';
		var dupCheck = '${dupCheck}';

		$(document).ready(function() {

			var ctx = "${pageContext.request.contextPath}";

			$("#dupCheck").click(function() {
				let username = $("#username").val();
				location.href = ctx
						+ "/UserController?username="
						+ username + "&type=dupcheck";
			});

            if(checkUser === '' && dupCheck === ''){
                
            }else{
                  if (dupCheck === 'false') {
                     $("#username").val('');
                     alert("not available")
                  } else {
                     $("#username").val(checkUser);
                     alert("Available ID.")
                  }                     
            }
					
			
		});
	</script>
</body>

</html>
