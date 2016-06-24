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
public class outactivity extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            register reg=new register();
            ResultSet rs = null,rs_1 = null;
            int a_id=Integer.parseInt(request.getParameter("a_id"));
            String entry=request.getParameter("entry");
            HttpSession session = request.getSession(true);
            String joinername=(String)session.getAttribute("username");
            
            try {
                reg.getConn();
                String sql = "delete from activityjoiner where a_id='"+a_id+"' and joinername='"+joinername+"'";
                reg.deleteConn(sql);
                if("showclub".equals(entry)){
                    String clubname=request.getParameter("clubname");
                    request.getRequestDispatcher("showclub.jsp?clubname="+clubname).forward(request, response);
                }else{
                    request.getRequestDispatcher("joinactivity.jsp").forward(request, response);
                }
                
                String sql_activity = "select * from clubactivity where a_id = "+a_id;
                rs_1 = reg.executeQuery(sql_activity);
                if(rs_1.next()){
                    String sql_owner = "select username from clubowner where clubname = '"+rs_1.getString("clubname")+"'";
                    rs = reg.executeQuery(sql_owner);
                    if(rs.next()){
                        String newMessage = "消息：你的社员："+joinername+",取消参加你的活动--"+rs_1.getString("title")+"!";
                        String sql_message = "insert into usermessage (username,content) values('"+rs.getString("username")+"','"+newMessage+"')";
                        reg.insertConn(sql_message);
                    }
                }
            } catch (Exception ex) {
                Logger.getLogger(createclub.class.getName()).log(Level.SEVERE, null, ex);
            }
            reg.dbclose();
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
