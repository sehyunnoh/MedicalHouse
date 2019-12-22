<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>

<div id="headerBox">
	<img id="logo" src="${pageContext.request.contextPath}/img/logo_1.png" alt="logo">
	<span class="headerUser"> User Name: <input class="inputName" value="${sessionScope.suInfo.fName} ${sessionScope.suInfo.lName}" ></span>
</div>
