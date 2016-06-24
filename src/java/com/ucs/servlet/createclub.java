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
public class createclub extends HttpServlet {

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
            ResultSet rs=null;
            String clubname=request.getParameter("clubname");
            String intro=request.getParameter("introduce");
            HttpSession session = request.getSession(true);
            String username=(String)session.getAttribute("username");
            if(clubname.indexOf("'")!=-1){  //含有单引号
                clubname=clubname.replaceAll("'","''");
            }
            if(intro.indexOf("'")!=-1){  //含有单引号
                intro=intro.replaceAll("'","''");
            }
            try {
                reg.getConn();
                String sql = "select * from clubowner where clubname = '" + clubname + "'";
                reg.executeQuery(sql);
                if(reg.executeQuery(sql).next()){
                    request.getRequestDispatcher("createclub.jsp").forward(request, response);
                }else{
                    String sql1 = "insert into clubowner (clubname,username,introduce) values('"+clubname+"','"+username+"','"+intro+"')";
                    reg.insertConn(sql1);
                    out.print("<script>alert(\"你已成功创建社团！\");</script>");
                    response.sendRedirect("myclub.jsp");
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
