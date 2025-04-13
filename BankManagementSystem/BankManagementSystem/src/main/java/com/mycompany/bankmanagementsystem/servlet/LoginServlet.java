/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.bankmanagementsystem.servlet;


import com.mycompany.bankmanagementsystem.dao.DBConnection;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String mobile = request.getParameter("mobile");
        String account_no = request.getParameter("account_no");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT * FROM user_details WHERE name=? AND mobile=? AND account_no=? AND email=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, mobile);
            ps.setString(3, account_no);
            ps.setString(4, email);
            ps.setString(5, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                HttpSession session = request.getSession();
                session.setAttribute("name", name);
                session.setAttribute("mobile", mobile);
                session.setAttribute("account_no", account_no);
                response.sendRedirect("userdetails.jsp");
            } else {
                response.sendRedirect("index.jsp?error=Incorrect+Information");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}

