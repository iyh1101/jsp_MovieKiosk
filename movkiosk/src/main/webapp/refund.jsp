<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓취소 환불</title>
<link rel="stylesheet" href="index.css">
</head>
<body>
	<%
		
	%>
	취소 환불하실 티켓의 번호 8자리를 입력해주세요<hr>
	<form action="refundProc.jsp" method="get">
		<input type="text" value="티켓번호" disabled>
		<input name="ticketNumber" type="tel" minlength="8" maxlength="8">
		<input name="mode" type="hidden" value="1">
		<input type="submit" value="번호조회">
	</form>
	<br><br>
	<input type="button" value="홈화면" onclick="location.href='bpcc.jsp'">
</body>
</html>