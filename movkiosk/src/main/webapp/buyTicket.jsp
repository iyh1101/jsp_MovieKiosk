<%@page import="java.sql.ResultSet"%>
<%@page import="com.peisia.util.mysql.MysqlProc"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>티켓구매</title>
</head>
<link rel="stylesheet" href="index.css">
<body>
	<div id="timeBox">
		<div id="buyText1">
		<zz id="buyText2">영화 선택</zz>
		</div>
		<hr>
		<%
		session.removeAttribute("tNum");
		
		Date d = new Date();
		int h = d.getHours();
		int m = d.getMinutes();
		String a = h+":"+m;
		System.out.println(a);
		
		int i = 0;
		int j = 0;
		String mcode = null;
		//array선언해서 포문으로 꺼낸 값 집어넣기
		try {
		MysqlProc.initDb();
		MysqlProc.connectDb();
		ResultSet rr = MysqlProc.exeQuery("select distinct mcode from movietime where mcode;");
		while(rr.next() ) {
			//안쓰지만 혹시몰라서
			mcode = rr.getString("mcode");
			j += 1;
			System.out.println("반복:"+j);
		}
		MysqlProc.disconnectDb();
		
		int[] array = new int[j];
		
		for(int y = 1; y <= j; y++) {
		MysqlProc.initDb();
		MysqlProc.connectDb();
		ResultSet rc = MysqlProc.exeQuery("select count(case when mcode="+y+" then 1 end) as count from movietime;");
		rc.next();
		//0번째부터 넣음
		array[y-1] = rc.getInt("count");
		System.out.println(y+"="+array[y-1]);
		MysqlProc.disconnectDb();
		}
		
		//4, 4 / array[x]
		MysqlProc.initDb();
		MysqlProc.connectDb();
		ResultSet rs = MysqlProc.exeQuery("select*from movietime");
		
		for(int w = 0; w < array.length; w++) {
			// 엠코드 값 만큼 반복
			System.out.println(w+"만큼 반복");
			for(int f = 0; f < array[w]; f++) {
				rs.next();
				String title = rs.getString("m_title");
				String section = rs.getString("m_section");
				String timetable = rs.getString("timetable");
				String seats = rs.getString("seats");
				String rseats = rs.getString("r_seats");
				String rseatNum = rs.getString("r_seatNum");
				int st = Integer.parseInt(seats);
				int rt = Integer.parseInt(rseats);
				
				if(f == 0) {
					%>
					<div id="buyText3">
					&nbsp;&nbsp;&nbsp;&nbsp;<%=title %>
					<br>
					&nbsp;&nbsp;상영관: <%=section %>
					</div>
					<%	}	%>
				<div id="buyText4">
	<a href="howmanypeople.jsp?title=<%=title%>&section=<%=section%>&timetable=<%=timetable%>&seats=<%=seats%>&rseats=<%=rseats%>&rseatNum=<%=rseatNum%>"><%=timetable %> | 좌석수: <%=st %>/<%=st-rt %></a>
				</div>
				<%	}	%>
			<hr>
			<%	}
			MysqlProc.disconnectDb();
		} catch(Exception e) {
			e.getStackTrace();
		}
		%>
	</div>
</body>
</html>
