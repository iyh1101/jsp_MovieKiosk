<%@page import="java.sql.ResultSet"%>
<%@page import="com.peisia.util.mysql.MysqlProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결제 화면</title>
<link rel="stylesheet" href="index.css">
</head>
<body>
	<%
	//예매한 좌석 리스트업
	String title = request.getParameter("title");
	String section = request.getParameter("section");
	String timetable = request.getParameter("timetable");
	String seats = request.getParameter("seats");
	String rseats = request.getParameter("rseats");
	int tseats = Integer.parseInt(request.getParameter("tseats") ); 
	String s1 = (String)session.getAttribute("s1");
	String s2 = (String)session.getAttribute("s2");
	String s3 = (String)session.getAttribute("s3");
	String s4 = (String)session.getAttribute("s4");
	int tNum = (int)session.getAttribute("tNum");
	int s1234 = 0;
	try{
		MysqlProc.initDb();
		MysqlProc.connectDb();
		ResultSet rs = MysqlProc.exeQuery("select count(*) as count from r_seatNum;");
		rs.next();
		s1234 = rs.getInt("count");
	} catch(Exception e) {
		e.getStackTrace();
	}
	
	if(tseats > 0) {
		%>
		<script>
		alert("남은 좌석의 선택을 완료해주세요");
		location.href="javascript:history.go(-1)";
		</script>
		<%
	}
	if(tseats == 0) {
		%>
		<form>
		예매 정보 확인<hr>
		제목:&nbsp;<%=title %><br>
		상영관:&nbsp;<%=section %><br>
		상영시간:&nbsp;<%=timetable %><br>
		총인원&nbsp;<%=s1234 %>명&nbsp;(
		<%
		if(!(s1.equals("0")) ) {
		%>
		성인&nbsp;<%=s1 %>명&nbsp;
		<%	
		}
		if(!(s2.equals("0")) ) {
		%>
		&nbsp;청소년&nbsp;<%=s2 %>명&nbsp;
		<%	
		}
		if(!(s3.equals("0")) ) {
		%>
		&nbsp;우대&nbsp;<%=s3 %>명&nbsp;
		<%	
		}
		if(!(s4.equals("0")) ) {
		%>
		&nbsp;경로&nbsp;<%=s4 %>명
		<%	
		}
		%>
		)		
		</form>
		예매좌석:&nbsp;[&nbsp;
		
		<%
		
	}
	
	try {
		MysqlProc.initDb();
		MysqlProc.connectDb();
		ResultSet rs = MysqlProc.exeQuery("select*from r_seatNum order by num asc;");
		while(rs.next() ) {
			String rNum = rs.getString("num");
			%>
				<%=rNum %>&nbsp;
			<%
		}
			%>
			&nbsp;]
			<br>
			결제금액:
		<%
			//1.5 1.2 0.5 0.7
			int t1 = Integer.parseInt(s1);
			int t2 = Integer.parseInt(s2);
			int t3 = Integer.parseInt(s3);
			int t4 = Integer.parseInt(s4);
			int total = 15000*t1 + 12000*t2 + 5000*t3 + 7000*t4;
		%>	
		<%=total %>원
		<br><br>
		<form action="payProc.jsp" method="get">
			<input type="submit" value="결제">
			<input name="title" type="hidden" value="<%=title%>">
			<input name="section" type="hidden" value="<%=section%>">
			<input name="timetable" type="hidden" value="<%=timetable%>">
			<input name="tNum" type="hidden" value="<%=tNum%>">
			<input name="s1" type="hidden" value="<%=s1%>">
			<input name="s2" type="hidden" value="<%=s2%>">
			<input name="s3" type="hidden" value="<%=s3%>">
			<input name="s4" type="hidden" value="<%=s4%>">
		</form>
		<br>
		<input type="button" value="뒤로가기" onclick="javascript:history.go(-1)">
			
			<%
		MysqlProc.disconnectDb();
	} catch(Exception e) {
		e.getStackTrace();
	}
	
	%>
	
</body>
</html>