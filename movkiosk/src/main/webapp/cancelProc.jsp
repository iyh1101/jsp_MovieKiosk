<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String title = request.getParameter("title");
		String section = request.getParameter("section");
		String seats = request.getParameter("seats");
		String timetable = request.getParameter("timetable");
		String m = request.getParameter("mode");
		String e_rseats = request.getParameter("e_rseats");
		String e_rseatNum = request.getParameter("e_rseatNum");
		//이전 좌석정보는 어트리뷰트로 설정했는데 왜 겟으로 가져온건지;;		
		%>
		<script>
	        if (confirm("예매를 취소하시겠습니까? [확인=예매취소 / 취소=이전화면]")) {
	            location.href="reselect.jsp?title=<%=title%>&section=<%=section%>&seats=<%=seats%>&timetable=<%=timetable%>&mode=<%=m%>&e_rseats=<%=e_rseats%>&e_rseatNum=<%=e_rseatNum%>";
	        } else {
	            location.href="javascript:history.go(-1)";
	        }
		</script>
		<%
	%>
	
	
</body>
</html>