package db;

import java.sql.*;
import javax.naming.*;
import javax.sql.*;

public class JdbcUtil {

	public static Connection getConnection() {
		Connection con = null;
	
		try{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/idenit");
			con = ds.getConnection();
			con.setAutoCommit(false);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return con;
	}
	
	
	// close 1 - con
	public static void close(Connection con) {
		try {
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// close 2 - stmt
	public static void close(Statement stmt) {
		try {
			stmt.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// close 3 - rs
	public static void close(ResultSet rs) {
		try {
			rs.close();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// commit
	public static void commit(Connection con) {
		try {
			con.commit();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	// rollback
	public static void rollback(Connection con) {
		try {
			con.rollback();
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	//
}

