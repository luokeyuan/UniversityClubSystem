/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ucs.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.ucs.jsp.register;
import java.sql.ResultSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author MR.l
 */
@MultipartConfig(location = "F:\\NetBeansProjects\\UniversityClubSystem\\build\\web")
public class changeinfoservlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private String fileNameExtractorRegex = "filename=\".+\"";
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        try {
            /* TODO output your page here. You may use following sample code. */
            register reg=new register();
            ResultSet rs=null;
            String sex=request.getParameter("sex");
            String school=request.getParameter("school");
            String phone=request.getParameter("phone");
            String email=request.getParameter("email");
            String intro=request.getParameter("intro");
            HttpSession session = request.getSession(true);
            
            //获取头像
//            String path = this.getServletContext().getRealPath("/");
//            Part p = request.getPart("pic");
//            String fn = "";
//            if(p!=null||!"".equals(p.toString())){
//                String fname = getFileName(p);
//                int index = fname.lastIndexOf('\\');
//                fn = fname.substring(index+1);
//                p.write(path+"Favicon\\"+fn);
//                out.write("bullllll");
//            }
            
            try {
                reg.getConn();
                String username=(String)session.getAttribute("username");
                if(sex!=""){
                    String sql="update register set sex='"+sex+"' where username='"+username+"'";
                    reg.updateConn(sql);
                }
                if(school!=""){
                    String sql="update register set school='"+school+"' where username='"+username+"'";
                    reg.updateConn(sql);
                }
                if(phone!=""){
                    String sql="update register set phone='"+phone+"' where username='"+username+"'";
                    reg.updateConn(sql);
                }
                if(email!=""){
                    String sql="update register set email='"+email+"' where username='"+username+"'";
                    reg.updateConn(sql);
                }
                if(intro!=""){
                    String sql="update register set introduce='"+intro+"' where username='"+username+"'";
                    reg.updateConn(sql);
                }
//                if(fn!=""){
//                    String sql="update register set image='"+fn+"' where username='"+username+"'";
//                    reg.updateConn(sql);
//                }
                request.getRequestDispatcher("/info.jsp").forward(request, response);
            } catch (Exception ex) {
                Logger.getLogger(changeinfoservlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } finally {
            out.close();
        }
    }

//    private String getFileName(Part part) { //获取input文件
//        String cotentDesc = part.getHeader("content-disposition");
//        String fileName = null;
//        Pattern pattern = Pattern.compile(fileNameExtractorRegex);
//        Matcher matcher = pattern.matcher(cotentDesc);
//        if(matcher.find()){
//            fileName = matcher.group();
//            fileName = fileName.substring(10, fileName.length()-1);
//        }
//        return fileName;
//    }
    
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
/*bug
如果上传文件为空，则发出异常，导致页面无法跳转

*/