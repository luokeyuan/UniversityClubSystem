/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ucs.jsp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author MR.l
 */
public class register {
    private Statement s=null;
    private ResultSet rs=null;
    private Connection conn=null;
    private String username=null,password=null,email=null;
    public register(){
        
    }
    public String setUsername(String username){
        return this.username=username;
    }
    public String getUsername(){
        return this.username;
    }
    public String setPassword(String password){
        return this.password=password;
    }
    public String getPassword(){
        return this.password;
    }
    
    public void getConn() throws Exception{
        String url="jdbc:mariadb://localhost:3306/UCS?user=root&password=root&useUnicode=true&characterEncoding=UTF8";
        try{
            /*Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
            conn=DriverManager.getConnection("jdbc:derby://localhost:1527/UCS", "mrl", "123456");*/
            Class.forName("org.mariadb.jdbc.Driver");
            conn=DriverManager.getConnection(url);
            s=conn.createStatement();
        }catch(Exception e){
            System.err.println("aq.executeQuery:"+e.getMessage());
        }
    }
    //查询sql
    public ResultSet executeQuery(String sql){
        try{
            rs=s.executeQuery(sql);
        }catch(Exception ex){
            System.err.println("aq.excuteQuery:"+ex.getMessage());
        }
        return rs;
    }
    //关闭数据库
    public void dbclose(){
        try{
            rs.close();
            conn.close();
            s.close();
        }catch(SQLException ex){
            System.err.println("aq.excuteQuery:"+ex.getMessage());
        }
    }
    //插入数据库
    public void insertConn(String sql){
        try{
            s.execute(sql);
        }catch(Exception e){
            System.err.println("aq.executeQuery:"+e.getMessage());
        }
    }
    //更新数据库
    public void updateConn(String sql){
        try {
            s.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(register.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}