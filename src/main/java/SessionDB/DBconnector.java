package SessionDB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DBconnector 
{
	static Connection cn = null;
	static Statement st = null;
	static ResultSet rs = null;
    
   static
   {
     try 
     {
	   Class.forName("com.mysql.cj.jdbc.Driver");
	   
	   cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/Inventory","root","root@1234");
	   
	   st = cn.createStatement();
	 } 
     catch(ClassNotFoundException e) 
     {
		System.out.println(e);
	 } 
     catch(SQLException e)
     {
    	System.out.println(e); 
     }
   }
   
   public static Connection getConnection()
   {
	 return cn; 
   }
   public static Statement getStatement()
   {
	 return st;
   }
}
