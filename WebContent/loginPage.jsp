<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet" type="text/css" href="css/style.css">
<script src="${pageContext.request.contextPath}/js/jquery.js"></script>
<title>login page</title>
</head>

<body class="body">
	<div id="formBox">
		<form action="SystemController" method="post">
			<label>ID<br> </label> <input type="text" name="id" placeholder="username" value="rray" required><br>
			<label>Password<br> </label> <input type="password" name="password" placeholder="password" value="password" required><br> <br>
			<input class="logbtn1" type="submit" name="submit" value="Login in"><br> 
			<input type="hidden" name="type" value="login">
		</form>
		<form action="pages/createProfile.jsp" method="post">
			<input class="logbtn1" type="submit" name="createAccount" value="Create account">
		</form>
	</div>
<script>

var message = '${message}';

$(document).ready(function(){
	if(message !== ""){
		alert(message);
	}
});


</script>
</body>

</html>