<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.peisia.util.mysql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	정보를 가져와서 다시 전달하기 위한 임시거처
	<br>
	<%
		// selectSeats에서 가져온 정보
		String title = request.getParameter("title");
		String section = request.getParameter("section");
		String timetable = request.getParameter("timetable");
		String seats = request.getParameter("seats");
		String rseats = request.getParameter("rseats");
		System.out.println("rseats"+rseats);
		String s1 = request.getParameter("s1");
		String s2 = request.getParameter("s2");
		String s3 = request.getParameter("s3");
		String s4 = request.getParameter("s4");
		
		//선택한 자리 위치 / 자리값 테이블에 넣어둠, 결제시에 좌석정보 꺼내기위해
		String seatNum = request.getParameter("seatNum");
		try{
			MysqlProc.initDb();
			MysqlProc.connectDb();
			MysqlProc.exeUpdate("insert into r_seatNum value('"+seatNum+"');");
			MysqlProc.disconnectDb();
		} catch(Exception e) {
			
		}
		
		//출력완료
		int is1 = Integer.parseInt(s1);
		int is2 = Integer.parseInt(s2);
		int is3 = Integer.parseInt(s3);
		int is4 = Integer.parseInt(s4);
		//예매 1번만 되게
		boolean tf = false;
		
		int check = 0;
		//티켓번호 생성
		//이미 생성된 번호가 있으면 그대로 쓰고
		int b = 0;
		try {
			b = (int)session.getAttribute("tNum");
			System.out.println("티켓번호 있음---------"+b);
			//b번호가 없으면 여기서 멈추고 캐치문으로 이동한다
			check = 1;
			System.out.println("check1---------"+check);
		} catch(Exception e) {
			boolean tf2 = true;
			
			while(tf2) {
			check = 2;
			System.out.println("check2---------"+check);
			//없을 경우엔 랜덤으로 돌려서 뽑는다
			int a = (int)(Math.random()*9999999);
			b = 90000000;
			b += a;
			//중복된 예매번호가 있는지 체크
			try {
				MysqlProc.initDb();
				MysqlProc.connectDb();
				ResultSet rs = MysqlProc.exeQuery("select count(*) as count from ticketinfo where t_num = "+b+";");
				rs.next();
				int dNum = rs.getInt("count");
				MysqlProc.disconnectDb();
				//숫자를 세서 0, 중복숫자가 없다면
				if(dNum == 0) {
					// 티켓번호 저장
					try {
						MysqlProc.initDb();
						MysqlProc.connectDb();
						MysqlProc.exeUpdate("insert into ticketinfo(t_num, t_seatNum) values ("+b+", '');");
						MysqlProc.disconnectDb();
						// 콘솔에도 저장
						session.setAttribute("tNum",b);
						System.out.println("새로운 번호---------"+b);
						
						tf2 = false;
					} catch(Exception y) {
						y.getStackTrace();
						}
				}
				} catch(Exception x) {
					System.out.println("번호중복체크 오류");
				}
			
			}
		}
		
		
		//111111111111111111111
		//빈자리 차감
		if(is1 > 0) {
			tf = true;
			is1 -= 1;
			System.out.println("인원수 줄었나 확인1"+is1);

		try {
			//티켓정보 저장
			MysqlProc.initDb();
			MysqlProc.connectDb();
			MysqlProc.exeUpdate("update ticketinfo set t_title='"+title+"', t_section='"+section+"', t_timetable='"+timetable+"', t_seatNum= concat(t_seatNum, '"+seatNum+" ') where t_num="+b+";");
			MysqlProc.disconnectDb();
			
			MysqlProc.initDb();
			MysqlProc.connectDb();
			
			int rset = Integer.parseInt(rseats);
			rset += 1;
			System.out.println("rset"+rset);
			MysqlProc.exeUpdate("update movietime set r_seats="+rset+", r_seatNum = concat(r_seatNum, '"+seatNum+" ') where m_title='"+title+"' and m_section='"+section+"' and timetable = '"+timetable+"';");
			MysqlProc.disconnectDb();
			
			MysqlProc.initDb();
			MysqlProc.connectDb();
			ResultSet rs = MysqlProc.exeQuery("select*from movietime where m_title='"+title+"' and m_section='"+section+"' and timetable='"+timetable+"';");
			rs.next();
			title = rs.getString("m_title");
			section = rs.getString("m_section");
			timetable = rs.getString("timetable");
			seats = rs.getString("seats");
			rseats = rs.getString("r_seats");
			String rseatNum = rs.getString("r_seatNum");

			
			
			%>
			<script>
			location.href="selectSeats.jsp?s1=<%=is1%>&s2=<%=is2%>&s3=<%=is3%>&s4=<%=is4%>&title=<%=title%>&section=<%=section%>&timetable=<%=timetable%>&seats=<%=seats%>&rseats=<%=rseats%>&rseatNum=<%=rseatNum%>";
			</script>	
			
			<%
			MysqlProc.disconnectDb();	
			} catch(Exception e) {
				e.getStackTrace();
			}
		}
		
		//22222222222222222
		if(tf == false && is2 > 0) {
			tf = true;
			is2 -= 1;
			System.out.println("인원수 줄었나 확인2"+is2);
			
			
		try {
			//티켓정보 저장
			MysqlProc.initDb();
			MysqlProc.connectDb();
			MysqlProc.exeUpdate("update ticketinfo set t_title='"+title+"', t_section='"+section+"', t_timetable='"+timetable+"', t_seatNum= concat(t_seatNum, '"+seatNum+" ') where t_num="+b+";");
			MysqlProc.disconnectDb();
			
			MysqlProc.initDb();
			MysqlProc.connectDb();
			
			int rset = Integer.parseInt(rseats);
			rset += 1;
			System.out.println("rset"+rset);
			MysqlProc.exeUpdate("update movietime set r_seats="+rset+", r_seatNum = concat(r_seatNum, '"+seatNum+" ') where m_title='"+title+"' and m_section='"+section+"' and timetable = '"+timetable+"';");
			MysqlProc.disconnectDb();
			
			MysqlProc.initDb();
			MysqlProc.connectDb();
			ResultSet rs = MysqlProc.exeQuery("select*from movietime where m_title='"+title+"' and m_section='"+section+"' and timetable='"+timetable+"';");
			rs.next();
			title = rs.getString("m_title");
			section = rs.getString("m_section");
			timetable = rs.getString("timetable");
			seats = rs.getString("seats");
			rseats = rs.getString("r_seats");
			String rseatNum = rs.getString("r_seatNum");
			%>
			<script>
			location.href="selectSeats.jsp?s1=<%=is1%>&s2=<%=is2%>&s3=<%=is3%>&s4=<%=is4%>&title=<%=title%>&section=<%=section%>&timetable=<%=timetable%>&seats=<%=seats%>&rseats=<%=rseats%>&rseatNum=<%=rseatNum%>";
			</script>	
			<%
			MysqlProc.disconnectDb();	
			} catch(Exception e) {
				e.getStackTrace();
			}
		}
		
		//3333333333
		if(tf == false && is3 > 0) {
			tf = true;
			is3 -= 1;
			System.out.println("인원수 줄었나 확인3"+is3);
			
			
			
		try {
			//티켓정보 저장
			MysqlProc.initDb();
			MysqlProc.connectDb();
			MysqlProc.exeUpdate("update ticketinfo set t_title='"+title+"', t_section='"+section+"', t_timetable='"+timetable+"', t_seatNum= concat(t_seatNum, '"+seatNum+" ') where t_num="+b+";");
			MysqlProc.disconnectDb();
			
			MysqlProc.initDb();
			MysqlProc.connectDb();
			
			int rset = Integer.parseInt(rseats);
			rset += 1;
			System.out.println("rset"+rset);
			MysqlProc.exeUpdate("update movietime set r_seats="+rset+", r_seatNum = concat(r_seatNum, '"+seatNum+" ') where m_title='"+title+"' and m_section='"+section+"' and timetable = '"+timetable+"';");
			MysqlProc.disconnectDb();
			
			MysqlProc.initDb();
			MysqlProc.connectDb();
			ResultSet rs = MysqlProc.exeQuery("select*from movietime where m_title='"+title+"' and m_section='"+section+"' and timetable='"+timetable+"';");
			rs.next();
			title = rs.getString("m_title");
			section = rs.getString("m_section");
			timetable = rs.getString("timetable");
			seats = rs.getString("seats");
			rseats = rs.getString("r_seats");
			String rseatNum = rs.getString("r_seatNum");
			%>
			<script>
			location.href="selectSeats.jsp?s1=<%=is1%>&s2=<%=is2%>&s3=<%=is3%>&s4=<%=is4%>&title=<%=title%>&section=<%=section%>&timetable=<%=timetable%>&seats=<%=seats%>&rseats=<%=rseats%>&rseatNum=<%=rseatNum%>";
			</script>	
			<%
			MysqlProc.disconnectDb();	
			} catch(Exception e) {
				e.getStackTrace();
			}
		}
		
		//4444444444444444444444
		if(tf == false && is4 > 0) {
			tf = true;
			is4 -= 1;
			System.out.println("인원수 줄었나 확인4"+is4);
			
			
		try {
			//티켓정보 저장
			MysqlProc.initDb();
			MysqlProc.connectDb();
			MysqlProc.exeUpdate("update ticketinfo set t_title='"+title+"', t_section='"+section+"', t_timetable='"+timetable+"', t_seatNum= concat(t_seatNum, '"+seatNum+" ') where t_num="+b+";");
			MysqlProc.disconnectDb();
			
			MysqlProc.initDb();
			MysqlProc.connectDb();
			
			int rset = Integer.parseInt(rseats);
			rset += 1;
			System.out.println("rset"+rset);
			MysqlProc.exeUpdate("update movietime set r_seats="+rset+", r_seatNum = concat(r_seatNum, '"+seatNum+" ') where m_title='"+title+"' and m_section='"+section+"' and timetable = '"+timetable+"';");
			MysqlProc.disconnectDb();
			
			MysqlProc.initDb();
			MysqlProc.connectDb();
			ResultSet rs = MysqlProc.exeQuery("select*from movietime where m_title='"+title+"' and m_section='"+section+"' and timetable='"+timetable+"';");
			rs.next();
			title = rs.getString("m_title");
			section = rs.getString("m_section");
			timetable = rs.getString("timetable");
			seats = rs.getString("seats");
			rseats = rs.getString("r_seats");
			String rseatNum = rs.getString("r_seatNum");
			%>
			<script>
			location.href="selectSeats.jsp?s1=<%=is1%>&s2=<%=is2%>&s3=<%=is3%>&s4=<%=is4%>&title=<%=title%>&section=<%=section%>&timetable=<%=timetable%>&seats=<%=seats%>&rseats=<%=rseats%>&rseatNum=<%=rseatNum%>";
			</script>
			<%
			MysqlProc.disconnectDb();	
			} catch(Exception e) {
				e.getStackTrace();
			}
		}
		
	%>
	
</body>
</html>