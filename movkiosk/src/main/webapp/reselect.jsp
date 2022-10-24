<%@page import="com.peisia.util.mysql.MysqlProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>재선택 또는 취소</title>
</head>
<body>
	
	<%
		// +)티켓번호 생성할때 티켓인포 테이블에 중복된 숫자잇으면 다시 돌아가게 만들어야한다
		//취소나 재선택 눌렀을때 정보 지우는 기능 만들어야 한다
		//delete from ticketinfo where t_num is d;
		// update movietime set r_seats='', r_seatNum='' where m_title=''
		// and m_section='' and timetable='';
		
		//기본좌석정보
		String s1 = (String)session.getAttribute("s1");
		String s2 = (String)session.getAttribute("s2");
		String s3 = (String)session.getAttribute("s3");
		String s4 = (String)session.getAttribute("s4");
		String title = request.getParameter("title");
		String section = request.getParameter("section");
		String seats = request.getParameter("seats");
		String timetable = request.getParameter("timetable");
		//취소 및 재선택 관련 정보
		String m = request.getParameter("mode");
		String e_rseats = request.getParameter("e_rseats");
		String e_rseatNum = request.getParameter("e_rseatNum");
		//s1234 title section timetable seats rseats rseatNum
		int tNum = 0;
		try {
		tNum = (int)session.getAttribute("tNum");
		
		} catch(Exception e) {
			System.out.println("티켓번호 없음");
		}
		
		switch(m) {
		// 좌석 재선택
		// 티켓번호 생긴경우에만 티켓정보(번호제외)초기화 좌석정보도 예매전으로
		case "1":
			if(tNum > 0) {
				try {
					MysqlProc.initDb();
					MysqlProc.connectDb();
					MysqlProc.exeUpdate("update ticketinfo set t_seatNum='' where t_num = "+tNum+";");
					MysqlProc.exeUpdate("update movietime set r_seats='"+e_rseats+"', r_seatNum='"+e_rseatNum+" ' where m_title='"+title+"' and m_section='"+section+"' and timetable='"+timetable+"';");
					MysqlProc.exeUpdate("delete from r_seatNum where num is not null;");
					MysqlProc.disconnectDb();
				} catch(Exception e) {
					e.getStackTrace();
				}
				%>
				<script>
				alert("좌석을 다시 선택합니다");
				location.href="selectSeats.jsp?s1=<%=s1%>&s2=<%=s2%>&s3=<%=s3%>&s4=<%=s4%>&title=<%=title%>&section=<%=section%>&timetable=<%=timetable%>&seats=<%=seats%>&rseats=<%=e_rseats%>&rseatNum=<%=e_rseatNum%>";
				</script>
				<%
			} else {
				// 좌석선택을 안하고 재선택눌렀을경우
				%>
				<script>
				alert("좌석을 선택하지 않았습니다");
				location.href="javascript:history.go(-1)";
				</script>
				<%
			}
			
			break;
			
		// 예매 취소
		// 좌석정보 예매전으로 / 티켓정보 생긴 상태면 티켓 지우고 없으면 좌석정보만 변경
		case "2":
			// 티켓정보 지우기
			if(tNum > 0) {
				System.out.println("티켓생성되서 티켓정보가 지워짐");
				try {
					MysqlProc.initDb();
					MysqlProc.connectDb();
					MysqlProc.exeUpdate("delete from ticketinfo where t_num = "+tNum+";");
					MysqlProc.disconnectDb();
				} catch(Exception e) {
					e.getStackTrace();
				}
			}
			// 예매했던거 원래대로 돌리기
			try {
				MysqlProc.initDb();
				MysqlProc.connectDb();
				MysqlProc.exeUpdate("update movietime set r_seats='"+e_rseats+"', r_seatNum='"+e_rseatNum+" ' where m_title='"+title+"' and m_section='"+section+"' and timetable='"+timetable+"';");
				MysqlProc.exeUpdate("delete from r_seatNum where num is not null;");
				MysqlProc.disconnectDb();
			} catch(Exception e) {
				e.getStackTrace();
			}
			// 저장되어있던 정보삭제
			session.removeAttribute("s1");
			session.removeAttribute("s2");
			session.removeAttribute("s3");
			session.removeAttribute("s4");
			session.removeAttribute("e_rseats");
			session.removeAttribute("e_rseatNum");
			session.removeAttribute("tNum");
			//session.removeAttribute();
			%>
			<script>
			alert("예매를 취소하여 선택화면으로 돌아갑니다");
			location.href="bpcc.jsp";
			</script>
			<%
			break;
			
		default:
			
		}
	%>
	

</body>
</html>