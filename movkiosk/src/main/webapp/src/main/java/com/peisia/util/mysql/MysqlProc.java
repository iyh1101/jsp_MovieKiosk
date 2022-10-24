package com.peisia.util.mysql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MysqlProc {
	static public String TABLE_BOARD = "cat_board";	//게시판 테이블 명
	static public int BOARD_LIST_AMOUNT = 5;	//게시판 페이지 당 보여줄 리스트 갯 수
	static public int BOARD_BLOCK_PAGE_AMOUNT = 3;	//게시판 페이지 블럭 당 보여줄 페이지 갯수
	static private Connection con = null;
	static private Statement st = null;
	
	static public void initDb() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}	
	
	static public void connectDb() {
		try {
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/my_board", "root", "admin");
			st = con.createStatement();
			System.out.println("==== 디비 접속 성공");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	static public ResultSet exeQuery(String sql) {
		try {
			return st.executeQuery(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	static public int exeUpdate(String sql) {
		try {
			return st.executeUpdate(sql);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -100;
	}
	
	static public void disconnectDb() {
		try {
			if(st!=null) {
				st.close();
			}
			if(con!=null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	static public int getDataCount() {
		connectDb();
		ResultSet rs = exeQuery("select count(*) from "+TABLE_BOARD);
		try {
			rs.next();
			int count = Integer.parseInt(rs.getString("count(*)")); 
			disconnectDb();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
		}
		disconnectDb();
		return 0;
	}
	
	/* 
	 * searchWord 값 검색어로 검색한 글 수를 리턴하는 함수
	 * */
	static public int getDataCount(String searchWord) {	// 함수 오버로딩.
		connectDb();
		String sql = "select count(*) from "+TABLE_BOARD+" where title like '%" + searchWord + "%'";
		System.out.println("갯수 새기(검색어 기준) sql:"+sql);
		ResultSet rs = exeQuery(sql);
		try {
			rs.next();
			int count = Integer.parseInt(rs.getString("count(*)")); 
			disconnectDb();
			return count;
		}catch(Exception e) {
			e.printStackTrace();
		}
		disconnectDb();
		return 0;
	}
}
