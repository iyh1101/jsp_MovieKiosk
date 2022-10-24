<%@page import="java.sql.ResultSet"%>
<%@page import="com.peisia.util.mysql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>좌석 선택</title>
<link rel="stylesheet" href="index.css">
</head>
<body>
	<%
		String url = request.getHeader("referer");
		
		String e_rseats = (String)session.getAttribute("e_rseats");
		String e_rseatNum = (String)session.getAttribute("e_rseatNum");
		
		String title = request.getParameter("title");
		String section = request.getParameter("section");
		String timetable = request.getParameter("timetable");
		String seats = request.getParameter("seats");
		int st = Integer.parseInt(seats);
		String rseats = request.getParameter("rseats");
		int rt = Integer.parseInt(rseats);
		String rseatNum = request.getParameter("rseatNum");
		String[] ar = rseatNum.split(" ");
		String[] ay = new String[1000];
		ay = rseatNum.split(" ");
		
		for(int i = 0; i < ar.length; i++) {
			System.out.println("반복횟수는"+ar[i]);
		}
		
		// 인원수 일반 청소년 장애인 경로우대순으로 몇명인지 체크
		String s1 = request.getParameter("s1");
		String s2 = request.getParameter("s2");
		String s3 = request.getParameter("s3");
		String s4 = request.getParameter("s4");
		
		// 초기 인원수값 세팅======================
		String v1 = (String)session.getAttribute("s1");
		// 값이 없거나 이전주소가 하우매니면 설정
		if(v1 == null || url.contains("howmanypeople")) {
			System.out.println("인원수 설정 함1 / "+s1);
			System.out.println("인원수 설정 함2 / "+s2);
			System.out.println("인원수 설정 함3 / "+s3);
			System.out.println("인원수 설정 함4 / "+s4);
			session.setAttribute("s1", s1);
			session.setAttribute("s2", s2);
			session.setAttribute("s3", s3);
			session.setAttribute("s4", s4);
			}
		
		
		int tseats = Integer.parseInt(s1) + Integer.parseInt(s2) + Integer.parseInt(s3) + Integer.parseInt(s4);
		
		if(url.contains("howmanypeople") && tseats == 0) {
			System.out.println("선택 인원수가 0");
			%>
			<script>
			alert("한명 이상의 인원을 선택해주세요");
			location.href="javascript:history.go(-1)";
			</script>
			<%
		}
		if(url.contains("saveSeats") && tseats == 0) {
			System.out.println("남은 좌석수가 0");
			//여기서 이제 선택화면으로 돌아와서 선택완료누르면 결제창에 정보 담아서 넘겨주면 된다
			%>
			<script>
			alert("좌석 선택을 완료하셨습니다");
			</script>
			<%
		}
		
		//선택한 인원수가 남아있는 자리수보다 많으면 뒤로가게
		
		if(tseats > st-rt) {
			%>
			<script>
			alert("선택하신 좌석수보다 남아있는 좌석수가 더 부족합니다");
			location.href="javascript:history.go(-1)";
			</script>
			<%
		}
		%>
			남은 인원수 : <%=tseats %>
			<br><br>
		<%
		switch(st) {
		
		//PRIVATE BOX
		case 8:
			int l = 65;
			
			for(int i = 1; i <= st; i++) {
				String s = Character.toString((char)l)+i;
				//i번째에 예약된 좌석번호와 같은경우에는 비활성화시키기,,,,
				boolean tf = false;
				
				for(int t = 0; t < ar.length; t++) {
				//System.out.println("ar:"+ar[t]);
				if(ar[t].equals(s) ) {
				%>
				<input type="submit" value="<%=s%>" disabled>
				<%
				tf = true;
					}
				}
				
				if(tf == false) {
			%>
			<form id="s1" action="saveSeats.jsp" method="get">
				<input type="submit" value="<%=s%>">
				<input name="title" type="hidden" value="<%=title%>">
				<input name="section" type="hidden" value="<%=section%>">
				<input name="timetable" type="hidden" value="<%=timetable%>">
				<input name="seats" type="hidden" value="<%=seats%>">
				<input name="rseats" type="hidden" value="<%=rseats%>">
				<input name="s1" type="hidden" value="<%=s1%>">
				<input name="s2" type="hidden" value="<%=s2%>">
				<input name="s3" type="hidden" value="<%=s3%>">
				<input name="s4" type="hidden" value="<%=s4%>">
				<input name="seatNum" type="hidden" value="<%=s%>">
			</form>
			<%
				} else if(tf == true) {
					
			}
		}
			break;
		
		// 14관
		case 170:
			int n = 65;
			
			//10번 반복 / 세로로 좌석배치
			for(int i = 1; i <= st/17; i++) {
				
				//17번 반복 / 가로로 좌석배치
				for(int j = 1; j <= st/10; j++) {
					String s14 = Character.toString((char)n)+j;
					boolean tf = false;
					for(int t = 0; t < ar.length; t++) {
						if(ar[t].equals(s14) ) {
							%>
							<input type="submit" value="<%=s14%>" disabled>
							<%
							tf = true;
						}
					}
					
					if(tf == false) {
					%>
					<form id="s2" action="saveSeats.jsp" method="get">
						<input type="submit" value="<%=s14%>">
						<input name="title" type="hidden" value="<%=title%>">
						<input name="section" type="hidden" value="<%=section%>">
						<input name="timetable" type="hidden" value="<%=timetable%>">
						<input name="seats" type="hidden" value="<%=seats%>">
						<input name="rseats" type="hidden" value="<%=rseats%>">
						<input name="s1" type="hidden" value="<%=s1%>">
						<input name="s2" type="hidden" value="<%=s2%>">
						<input name="s3" type="hidden" value="<%=s3%>">
						<input name="s4" type="hidden" value="<%=s4%>">
						<input name="seatNum" type="hidden" value="<%=s14%>">
					</form>
					&nbsp;
					<%
					} else if(tf == true) {
						
					}
				}
				n++;
				%>
				<br>
				<%
			}
			break;
		
		// 7관
		case 204:
			int m = 65;
			
			//12번 반복 / 세로로 좌석배치
			for(int i = 1; i <= st/17; i++) {
				
				//17번 반복 / 가로로 좌석배치
				for(int j = 1; j <= st/12; j++) {
					String s7 = Character.toString((char)m)+j;
					boolean tf = false;
					
					for(int t = 0; t < ar.length; t++) {
						if(ar[t].equals(s7) ) {
							%>
							<input type="submit" value="<%=s7%>" disabled>
							<%
							tf = true;
						}
					}
					
					if(tf == false) {
					%>
					<form id="s3" action="saveSeats.jsp" method="get">
						<input type="submit" value="<%=s7%>">
						<input name="title" type="hidden" value="<%=title%>">
						<input name="section" type="hidden" value="<%=section%>">
						<input name="timetable" type="hidden" value="<%=timetable%>">
						<input name="seats" type="hidden" value="<%=seats%>">
						<input name="rseats" type="hidden" value="<%=rseats%>">
						<input name="s1" type="hidden" value="<%=s1%>">
						<input name="s2" type="hidden" value="<%=s2%>">
						<input name="s3" type="hidden" value="<%=s3%>">
						<input name="s4" type="hidden" value="<%=s4%>">
						<input name="seatNum" type="hidden" value="<%=s7%>">
					</form>
					&nbsp;
					<%
					} else if(tf == true) {
						
					}
				}
				m++;
				%>
				<br>
				<%
			}
			break;
			
		}
		
		%>
		<br><br><br>
		<form action="pay.jsp">
			<input type="submit" value="선택완료">
			<input name="title" type="hidden" value="<%=title%>">
			<input name="section" type="hidden" value="<%=section%>">
			<input name="timetable" type="hidden" value="<%=timetable%>">
			<input name="seats" type="hidden" value="<%=seats%>">
			<input name="rseats" type="hidden" value="<%=rseats%>">
			<input name="s1" type="hidden" value="<%=s1%>">
			<input name="s2" type="hidden" value="<%=s2%>">
			<input name="s3" type="hidden" value="<%=s3%>">
			<input name="s4" type="hidden" value="<%=s4%>">
			<input name="tseats" type="hidden" value="<%=tseats%>">
		</form>
		<br>
		<form action="reselect.jsp" method="get">
			<input type="submit" value="좌석재선택">
			<input name="title" type="hidden" value="<%=title%>">
			<input name="section" type="hidden" value="<%=section%>">
			<input name="seats" type="hidden" value="<%=seats%>">
			<input name="timetable" type="hidden" value="<%=timetable%>">
			<input name="mode" type="hidden" value="1">
			<input name="e_rseats" type="hidden" value="<%=e_rseats%>">
			<input name="e_rseatNum" type="hidden" value="<%=e_rseatNum%>">
		</form>
		<br>
		<form action="cancelProc.jsp" method="get">
			<input type="submit" value="예매취소">
			<input name="title" type="hidden" value="<%=title%>">
			<input name="section" type="hidden" value="<%=section%>">
			<input name="seats" type="hidden" value="<%=seats%>">
			<input name="timetable" type="hidden" value="<%=timetable%>">
			<input name="mode" type="hidden" value="2">
			<input name="e_rseats" type="hidden" value="<%=e_rseats%>">
			<input name="e_rseatNum" type="hidden" value="<%=e_rseatNum%>">
		</form>
		
	
	
</body>
</html>