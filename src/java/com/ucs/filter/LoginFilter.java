/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ucs.filter;

import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author MR.l
 */
public class LoginFilter implements Filter {
    
    private FilterConfig config;
    
    public void doFilter(ServletRequest request, ServletResponse response,
            FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse res = (HttpServletResponse)response;
        HttpSession session = req.getSession();
        
        
        String noLoginPaths = config.getInitParameter("noLoginPaths");
        if(noLoginPaths!=null){
            String[] strArray = noLoginPaths.split(";");
            for(int i = 0; i < strArray.length; i++){
                if(strArray[i]==null||"".equals(strArray[i])) continue;
                if(req.getRequestURI().indexOf(strArray[i])!=-1){
                    chain.doFilter(request, response);
                    return;
                }
            }
        }
        
        
        if(session.getAttribute("username")!=null||session.getAttribute("adminname")!=null){
            chain.doFilter(request, response);
        }else{
            res.sendRedirect("index.jsp");
        }
    }

    /**
     * Destroy method for this filter
     */
    public void destroy() {        
    }

    /**
     * Init method for this filter
     */
    public void init(FilterConfig filterConfig) { 
        config = filterConfig;
    }

}
