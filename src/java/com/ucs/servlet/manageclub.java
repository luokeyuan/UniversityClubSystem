/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ucs.servlet;

import com.ucs.jsp.register;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MR.l
 */
public class manageclub extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter out = response.getWriter();
        try {
            register reg=new register();
            ResultSet rs=null;
            
            HttpSession session = request.getSession(true);
            String username=(String)session.getAttribute("username");
            
            String formcontent = request.getParameter("formcontent");
            String clubname=request.getParameter("clubname");
            
            if(formcontent.equals("clubnotice")){ //发布公告
                String content=request.getParameter("content");
                if(content.indexOf("'")!=-1){  //含有单引号
                    content=content.replaceAll("'","''");
                }
                    //记录公告发布时间
                    Date date = new Date();
                    DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String time=format.format(date);
                try {
                    reg.getConn();
                    String sql1 = "insert into clubnotice (clubname,content,datetime) values('"+clubname+"','"+content+"','"+time+"')";
                    reg.insertConn(sql1);
                    request.getRequestDispatcher("/manageclub.jsp?clubname="+clubname).forward(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(createclub.class.getName()).log(Level.SEVERE, null, ex);
                }
                reg.dbclose();
            }
            
            if(formcontent.equals("clubactivity")){ //发布社团活动
                String actTitle=request.getParameter("actTitle");
                String actContent=request.getParameter("actContent");
                
                if(actTitle.indexOf("'")!=-1){  //含有单引号
                    actTitle=actTitle.replaceAll("'","''");
                }
                if(actContent.indexOf("'")!=-1){  //含有单引号
                    actContent=actContent.replaceAll("'","''");
                }
                //记录活动发布时间
                Date date = new Date();
                DateFormat format=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String time=format.format(date);
                try {
                    reg.getConn();
                    String sql1 = "insert into clubactivity (clubname,title,content,datetime) values('"+clubname+"','"+actTitle+"','"+actContent+"','"+time+"')";
                    reg.insertConn(sql1);
                    request.getRequestDispatcher("/manageclub.jsp?clubname="+clubname).forward(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(createclub.class.getName()).log(Level.SEVERE, null, ex);
                }
                reg.dbclose();
            }
            
            if(formcontent.equals("clubinfo")){  //修改社团信息
                String introduce=request.getParameter("introduce");
                if(introduce.indexOf("'")!=-1){  //含有单引号
                    introduce=introduce.replaceAll("'","''");
                }
                try {
                    reg.getConn();
                    String sql1 = "update clubowner set introduce='"+introduce+"' where clubname='"+clubname+"'";
                    reg.insertConn(sql1);
                    request.getRequestDispatcher("/manageclub.jsp?clubname="+clubname).forward(request, response);
                } catch (Exception ex) {
                    Logger.getLogger(createclub.class.getName()).log(Level.SEVERE, null, ex);
                }
                reg.dbclose();
            }
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
