<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.peisia.util.mysql.MysqlProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓화면</title>
<link rel="stylesheet" href="index.css">
</head>
<body>
	<%
	String title = request.getParameter("title");
	String section = request.getParameter("section");
	String timetable = request.getParameter("timetable");
	String tNum = request.getParameter("tNum");
	String s1 = request.getParameter("s1");
	String s2 = request.getParameter("s2");
	String s3 = request.getParameter("s3");
	String s4 = request.getParameter("s4");
	String e_rseats = (String)session.getAttribute("e_rseats");
	String e_rseatNum = (String)session.getAttribute("e_rseatNum");
	
	int s1234 = 0;
	String m_age = "";
	String m_date = "";
	try {
		//티켓에 넣을 영화등급, 상영일자 가져오고 넣기
		MysqlProc.initDb();
		MysqlProc.connectDb();
		ResultSet rc = MysqlProc.exeQuery("select m_age from kiosk where m_title = '"+title+"';");
		rc.next();
		m_age = rc.getString("m_age");
		MysqlProc.disconnectDb();
		
		MysqlProc.connectDb();
		ResultSet rv = MysqlProc.exeQuery("select m_date from movietime where m_section = '"+section+"' and timetable = '"+timetable+"' and m_title = '"+title+"';");
		rv.next();
		m_date = rv.getString("m_date");
		MysqlProc.disconnectDb();
		
		//티켓에 넣음
		MysqlProc.connectDb();
		MysqlProc.exeUpdate("update ticketinfo set t_age='"+m_age+"', t_date='"+m_date+"' where t_num="+tNum+";");
		System.out.println("weffdf=========="+m_age+m_date);
		MysqlProc.disconnectDb();
		
		
	} catch(Exception e) {
		e.getStackTrace();
	}
	
	try{
		MysqlProc.initDb();
		MysqlProc.connectDb();
		ResultSet rs = MysqlProc.exeQuery("select count(*) as count from r_seatNum;");
		rs.next();
		s1234 = rs.getInt("count");
	} catch(Exception e) {
		e.getStackTrace();
	}
	
	%>
	<form>
		영화입장권<hr>
		
		제목:&nbsp;<%=title %><br>
		&nbsp;<%=m_age %><br>
		상영관:&nbsp;<%=section %><br>
		상영시간:&nbsp;<%=m_date %>&nbsp;<%=timetable %><br>
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
			&nbsp;]<br>
		예매번호: <%=tNum %>
		<br><br>
		<input type="button" value="홈화면" onclick="location.href='index.html'">
			
			<%
		MysqlProc.disconnectDb();
			
		MysqlProc.connectDb();
		// 결제후 좌석정보 담은것만 지우고 티켓정보랑 좌석업데이트된건 그대로 둬야함
		MysqlProc.exeUpdate("delete from r_seatNum where num is not null;");
		MysqlProc.disconnectDb();
	} catch(Exception e) {
		e.getStackTrace();
	}
		
		session.removeAttribute("s1");
		session.removeAttribute("s2");
		session.removeAttribute("s3");
		session.removeAttribute("s4");
		session.removeAttribute("e_rseats");
		session.removeAttribute("e_rseatNum");
		session.removeAttribute("tNum");
	%>
	
</body>
</html>