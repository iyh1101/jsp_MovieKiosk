<%@page import="java.sql.ResultSet"%>
<%@page import="com.peisia.util.mysql.MysqlProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>인원 수 선택</title>
<link rel="stylesheet" href="index.css">
</head>
<body>
	
	<%
		String title = request.getParameter("title");
		String section = request.getParameter("section");
		String timetable = request.getParameter("timetable");
		String seats = request.getParameter("seats");
		String rseats = request.getParameter("rseats");
		String rseatNum = request.getParameter("rseatNum");
		
		System.out.println("제목:"+title);
		System.out.println("상영관:"+section);
		System.out.println("시간:"+timetable);
		System.out.println("좌석수:"+seats);

		//취소나 재선택 눌렀을때 정보 지우는 기능을 위해 미리 데이터 저장해두는 용도로
		//delete from ticketinfo where t_num is d;
		// update movietime set r_seats='', r_seatNum='' where m_title='' and m_section='' and timetable='';
		try{
		MysqlProc.initDb();
		MysqlProc.connectDb();
		
		ResultSet rs = MysqlProc.exeQuery("select*from movietime where m_title='"+title+"' and m_section='"+section+"' and timetable='"+timetable+"';");
		rs.next();
		//이게 다 필요한가?
		String e_title = rs.getString("m_title");
		String e_section = rs.getString("m_section");
		String e_date = rs.getString("m_date");
		String e_timetable = rs.getString("timetable");
		String e_seats = rs.getString("seats");
		String e_rseats = rs.getString("r_seats");
		String e_rseatNum = rs.getString("r_seatNum");
		MysqlProc.disconnectDb();
		
		session.setAttribute("e_rseats", e_rseats);	
		session.setAttribute("e_rseatNum", e_rseatNum);
		
		} catch(Exception e) {
			e.getStackTrace();
		}
		
	%>
		<br>
		<input type="button" value="뒤로가기" onclick="javascript:history.go(-1)"><br><br>
		영화 : <%=title%> | <%=section%> | <%=timetable %>
		<br><br>
	<form action="selectSeats.jsp" method="get">
		예매하실 인원 수를 선택해주세요<br><br>
		일반<select name="s1">
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
		</select><br><br>
		청소년<select name="s2">
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
		</select><br><br>
		우대<select name="s3">
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
		</select><br><br>
		경로<select name="s4">
			<option value="0">0</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
			<option value="8">8</option>
		</select>
	<input name="title" type="hidden" value="<%=title%>">
	<input name="section" type="hidden" value="<%=section%>">
	<input name="timetable" type="hidden" value="<%=timetable%>">
	<input name="seats" type="hidden" value="<%=seats%>">
	<input name="rseats" type="hidden" value="<%=rseats%>">
	<input name="rseatNum" type="hidden" value="<%=rseatNum%>">
	<br><br>&nbsp;&nbsp;
	<input type="submit" value="좌석선택">
	</form>
	
	
	
</body>
</html>