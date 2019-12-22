<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div>
	<c:choose>
		<c:when test="${sessionScope.suInfo.role == '1'}">
			<ul class="leftMenu">
				<li><a href="#">update user profile</a></li>
				<li><a href="./appointPage.jsp">start today's task</a></li>
				<li><a href="#">log out</a></li>
			</ul>
		</c:when>
		<c:when test="${sessionScope.suInfo.role == '2'}">
			<ul class="leftMenu">
				<li><a href="CalendarController?ptype=view">register / appointment</a></li>
				<li><a href="MedicalController?type=view">Medical History</a></li>
				<!-- <li><a href="CalendarController?ptype=view">register</a></li> -->
				<li><a href="UserController?type=view">user profile</a></li>
				<li><a href="UserController?type=logout">log out</a></li>
			</ul>
			<br />
		</c:when>
		<c:otherwise>
		</c:otherwise>
	</c:choose>

</div>

