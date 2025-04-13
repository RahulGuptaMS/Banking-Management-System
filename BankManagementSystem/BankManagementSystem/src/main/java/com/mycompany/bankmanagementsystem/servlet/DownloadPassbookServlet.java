/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.bankmanagementsystem.servlet;

import com.mycompany.bankmanagementsystem.dao.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.*;
import java.sql.*;

@WebServlet("/DownloadPassbookServlet")
public class DownloadPassbookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String account_no = (String) session.getAttribute("account_no");
        String name = (String) session.getAttribute("name");

        if (account_no == null || name == null) {
            response.sendRedirect("index.jsp?error=Please+login+first");
            return;
        }

        // Create a safe file name
        String safeName = name.replaceAll("\\s+", "_");
        String fileName = "Passbook_" + safeName + "_" + account_no + ".csv";

        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=" + fileName);

        try (PrintWriter writer = response.getWriter()) {
            writer.println("Date,Debit,Credit,Total");

            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM transactions WHERE account_no = ? ORDER BY date DESC"
            );
            ps.setString(1, account_no);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String date = rs.getTimestamp("date").toString();
                String debit = rs.getDouble("debit") > 0 ? String.valueOf(rs.getDouble("debit")) : "-";
                String credit = rs.getDouble("credit") > 0 ? String.valueOf(rs.getDouble("credit")) : "-";
                String total = String.valueOf(rs.getDouble("total"));

                writer.println(date + "," + debit + "," + credit + "," + total);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
