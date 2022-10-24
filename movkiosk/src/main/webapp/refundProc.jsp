<%@page import="java.sql.ResultSet"%>
<%@page import="com.peisia.util.mysql.MysqlProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="index.css">
</head>
<body>
	<%
		String tNum = request.getParameter("ticketNumber");
		int mode = Integer.parseInt(request.getParameter("mode") );
		if(mode == 1) {
		try {
			MysqlProc.initDb();
			MysqlProc.connectDb();
			ResultSet rs = MysqlProc.exeQuery("select count(*) as count from ticketinfo where t_num="+tNum+";");
			rs.next();
			int count = rs.getInt("count");
			MysqlProc.disconnectDb();
			if(count == 0) {
				%>
				<script>
				alert("취소 및 환불 가능한 티켓이 없거나 잘못입력하셨습니다");
				location.href="refund.jsp";
				</script>
				<%
			}
			else {
				try {
					MysqlProc.initDb();
					MysqlProc.connectDb();
					ResultSet rc = MysqlProc.exeQuery("select*from ticketinfo where t_num="+tNum+";");
					rc.next();
					String t_num = rc.getString("t_num");
					String t_age = rc.getString("t_age");
					String t_date = rc.getString("t_date");
					String t_title = rc.getString("t_title");
					String t_section = rc.getString("t_section");
					String t_timetable = rc.getString("t_timetable");
					String t_seatNum = rc.getString("t_seatNum");
					
					
					%>
					예매번호<%=t_num %><hr>
					<%=t_title %><br>
					등급: <%=t_age %><br>
					상영일: <%=t_date %><br>
					상영관: <%=t_section %><br>
					상영시간: <%=t_timetable %><br>
					좌석: <%=t_seatNum %><br>
					<%			
					MysqlProc.disconnectDb();
							
					
				} catch(Exception e) {
					e.getStackTrace();
				}
			}
		} catch(Exception e) {
			e.getStackTrace();
		}
	%>
		<form action="refundProc.jsp" method="post">
			<input type="submit" value="예매취소">
			<input name="mode" type="hidden" value="2">
			<input name="ticketNumber" type="hidden" value="<%=tNum%>">
			<input type="button" value="메인화면" onclick="location.href='bpcc.jsp'">
		</form>
	<%
		}
		String arr = "";
		if(mode == 2) {
			try {
			MysqlProc.initDb();
			//영화정보에서 빼기
			MysqlProc.connectDb();
			ResultSet rs = MysqlProc.exeQuery("select*from ticketinfo where t_num="+tNum+";");
			rs.next();
			String t_date = rs.getString("t_date");
			String t_title = rs.getString("t_title");
			String t_section = rs.getString("t_section");
			String t_timetable = rs.getString("t_timetable");
			String t_seatNum = rs.getString("t_seatNum");
			String[] ar = t_seatNum.split(" ");
			arr = Integer.toString(ar.length);
			
			MysqlProc.disconnectDb();
			//티켓삭제				
			MysqlProc.connectDb();
			MysqlProc.exeUpdate("delete from ticketinfo where t_num ="+tNum+";");
			MysqlProc.disconnectDb();

			MysqlProc.connectDb();
			MysqlProc.exeUpdate("update movietime set r_seats=r_seats-"+arr+", r_seatNum = TRIM(TRAILING '"+t_seatNum+"' FROM r_seatNum) where m_title='"+t_title+"' and m_section='"+t_section+"' and m_date='"+t_date+"' and timetable='"+t_timetable+"';");
			MysqlProc.disconnectDb();
			
			%>
			<script>
			alert("예매취소완료");
			location.href="index.html"
			</script>
			<%
			} catch(Exception e) {
				e.getStackTrace();
			}
		}
	%>
</body>
</html>