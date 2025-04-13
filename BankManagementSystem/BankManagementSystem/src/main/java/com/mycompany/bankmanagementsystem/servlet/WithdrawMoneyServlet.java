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
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/WithdrawMoneyServlet")
public class WithdrawMoneyServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String account_no = (String) session.getAttribute("account_no");
        double amount = Double.parseDouble(request.getParameter("amount"));

        // Check if amount is zero
        if (amount == 0) {
            response.sendRedirect("withdraw.jsp?error=Amount+cannot+be+zero");
            return;
        }

        if (account_no == null) {
            response.sendRedirect("index.jsp?error=Please+login+first");
            return;
        }

        // Database connection and withdrawal logic
        try {
            Connection conn = DBConnection.getConnection();
            String sql = "SELECT total FROM transactions WHERE account_no = ? ORDER BY date DESC LIMIT 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, account_no);
            ResultSet rs = ps.executeQuery();

            double currentTotal = 0;
            if (rs.next()) {
                currentTotal = rs.getDouble("total");
            }

            if (currentTotal < amount) {
                response.sendRedirect("withdraw.jsp?error=Insufficient+balance");
                return;
            }

            double newTotal = currentTotal - amount;

            // Insert the transaction into the database
            String insertQuery = "INSERT INTO transactions (account_no, debit, total) VALUES (?, ?, ?)";
            PreparedStatement insertStmt = conn.prepareStatement(insertQuery);
            insertStmt.setString(1, account_no);
            insertStmt.setDouble(2, amount);  // Credit is the withdrawn amount
            insertStmt.setDouble(3, newTotal);
            insertStmt.executeUpdate();

            response.sendRedirect("userdetails.jsp?msg=Amount+withdrawn+successfully");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("withdraw.jsp?error=Failed+to+withdraw+money");
        } catch (Exception ex) {
            Logger.getLogger(WithdrawMoneyServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
