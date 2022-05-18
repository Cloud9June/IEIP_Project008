package com.sungil.database;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnect {

	public static Connection getConnection() {
		
		Connection conn = null;
		
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String id = "system";
		String pw = "1234";
		String drv = "oracle.jdbc.OracleDriver";
		
		try {
			Class.forName(drv);
			conn = DriverManager.getConnection(url, id, pw);
			System.out.println("Connected!!");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return conn;
	}
}
