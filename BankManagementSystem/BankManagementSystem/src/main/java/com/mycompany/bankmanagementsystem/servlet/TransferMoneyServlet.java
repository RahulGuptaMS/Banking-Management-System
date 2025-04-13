/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.bankmanagementsystem.servlet;

import com.mycompany.bankmanagementsystem.dao.DBConnection;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import java.io.IOException;
import java.sql.*;

@WebServlet("/TransferMoneyServlet")
public class TransferMoneyServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String sender_account = (String) session.getAttribute("account_no");
        String sender_name = (String) session.getAttribute("name");
        String receiver_account = request.getParameter("receiver_account_no");
        double amount = Double.parseDouble(request.getParameter("amount"));

        if (amount <= 0) {
            response.sendRedirect("transfer.jsp?msg=Invalid amount");
            return;
        }

        try {
            Connection conn = DBConnection.getConnection();

            // Check if receiver exists
            PreparedStatement checkReceiver = conn.prepareStatement("SELECT * FROM user_details WHERE account_no = ?");
            checkReceiver.setString(1, receiver_account);
            ResultSet receiverResult = checkReceiver.executeQuery();

            if (!receiverResult.next()) {
                response.sendRedirect("transfer.jsp?msg=Receiver not found");
                return;
            }

            // Get sender's latest total amount
            PreparedStatement getSenderBalance = conn.prepareStatement("SELECT total FROM transactions WHERE account_no = ? ORDER BY date DESC LIMIT 1");
            getSenderBalance.setString(1, sender_account);
            ResultSet senderRs = getSenderBalance.executeQuery();
            double senderBalance = 0;
            if (senderRs.next()) {
                senderBalance = senderRs.getDouble("total");
            }

            if (amount > senderBalance) {
                response.sendRedirect("transfer.jsp?msg=Insufficient balance");
                return;
            }

            double senderNewBalance = senderBalance - amount;

            // Insert debit for sender
            PreparedStatement debitSender = conn.prepareStatement("INSERT INTO transactions (account_no, debit, credit, total) VALUES (?, ?, ?, ?)");
            debitSender.setString(1, sender_account);
            debitSender.setDouble(2, amount);
            debitSender.setNull(3, Types.DOUBLE);
            debitSender.setDouble(4, senderNewBalance);
            debitSender.executeUpdate();

            // Get receiver's latest total
            PreparedStatement getReceiverBalance = conn.prepareStatement("SELECT total FROM transactions WHERE account_no = ? ORDER BY date DESC LIMIT 1");
            getReceiverBalance.setString(1, receiver_account);
            ResultSet receiverRs = getReceiverBalance.executeQuery();
            double receiverBalance = 0;
            if (receiverRs.next()) {
                receiverBalance = receiverRs.getDouble("total");
            }

            double receiverNewBalance = receiverBalance + amount;

            // Insert credit for receiver
            PreparedStatement creditReceiver = conn.prepareStatement("INSERT INTO transactions (account_no, debit, credit, total) VALUES (?, ?, ?, ?)");
            creditReceiver.setString(1, receiver_account);
            creditReceiver.setNull(2, Types.DOUBLE);
            creditReceiver.setDouble(3, amount);
            creditReceiver.setDouble(4, receiverNewBalance);
            creditReceiver.executeUpdate();

            response.sendRedirect("transfer.jsp?msg=Transaction Successful");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("transfer.jsp?msg=Transaction Failed");
        }
    }
}

