<%-- 
    Document   : userdetails
    Created on : 12-Apr-2025, 2:08:38 pm
    Author     : Rahul Kumar 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.mycompany.bankmanagementsystem.dao.DBConnection" %>
<%@ page session="true" %>
<%
    String name = (String) session.getAttribute("name");
    String mobile = (String) session.getAttribute("mobile");
    String account_no = (String) session.getAttribute("account_no");

    if (name == null || account_no == null) {
        response.sendRedirect("index.jsp?error=Please+login+first");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard - Bank Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="text-center mb-4">Welcome, <%= name %></h2>

    <div class="mb-3">
        <strong>Account Number:</strong> <%= account_no %><br/>
        <strong>Mobile:</strong> <%= mobile %>
    </div>

    <div class="mb-4">
        <a href="addmoney.jsp" class="btn btn-success">Add Money</a>
        <a href="withdraw.jsp" class="btn btn-danger">Withdraw</a>
                <!-- Transaction button that triggers modal -->

    </div>
    <div class="mb-4">

    <!-- New Feature Buttons -->
    <button class="btn btn-info ms-2" data-bs-toggle="modal" data-bs-target="#passbookModal">Passbook</button>
    <button class="btn btn-warning ms-2" data-bs-toggle="modal" data-bs-target="#userInfoModal">User Information</button>
    <button class="btn btn-secondary ms-2" data-bs-toggle="modal" data-bs-target="#loanModal">Add Loan</button>
    <button class="btn btn-dark ms-2" data-bs-toggle="modal" data-bs-target="#insuranceModal">Insurance</button>
    <button class="btn btn-outline-primary ms-2" data-bs-toggle="modal" data-bs-target="#atmCardModal">ATM Card</button>
    <button class="btn btn-outline-danger ms-2" data-bs-toggle="modal" data-bs-target="#contactModal">Contact Us</button>
</div>
    
     <!-- Log Out Button -->
    <div class="mb-3 text-center">
        <a href="index.jsp" class="btn btn-danger">Log Out</a>
    </div>


<h4>Transaction History</h4>

<!-- 🆕 Scrollable container for the table -->
<div style="max-height: 300px; overflow-y: auto;">
    <table class="table table-bordered table-striped mt-3">
        <thead class="table-dark">
            <tr>
                <th>Date</th>
                <th>Debit</th>
                <th>Credit</th>
                <th>Total</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM transactions WHERE account_no=? ORDER BY date DESC");
                    ps.setString(1, account_no);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getTimestamp("date") + "</td>");
                        out.println("<td>" + (rs.getDouble("debit") > 0 ? rs.getDouble("debit") : "-") + "</td>");
                        out.println("<td>" + (rs.getDouble("credit") > 0 ? rs.getDouble("credit") : "-") + "</td>");
                        out.println("<td>" + rs.getDouble("total") + "</td>");
                        out.println("</tr>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</div>
        <!-- Passbook Modal -->
<div class="modal fade" id="passbookModal" tabindex="-1" aria-labelledby="passbookModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-xl">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">Passbook</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
      </div>
      <div class="modal-body">
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Account Number:</strong> <%= account_no %></p>
        <div class="table-responsive" style="max-height: 300px; overflow-y: auto;">
          <table class="table table-bordered">
            <thead>
              <tr>
                <th>Date</th>
                <th>Debit</th>
                <th>Credit</th>
                <th>Total</th>
              </tr>
            </thead>
            <tbody>
              <%
                try {
                    Connection conn = DBConnection.getConnection();
                    PreparedStatement ps = conn.prepareStatement("SELECT * FROM transactions WHERE account_no=? ORDER BY date DESC");
                    ps.setString(1, account_no);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
              %>
                <tr>
                  <td><%= rs.getTimestamp("date") %></td>
                  <td><%= rs.getDouble("debit") > 0 ? rs.getDouble("debit") : "-" %></td>
                  <td><%= rs.getDouble("credit") > 0 ? rs.getDouble("credit") : "-" %></td>
                  <td><%= rs.getDouble("total") %></td>
                </tr>
              <% } conn.close(); } catch(Exception e) { e.printStackTrace(); } %>
            </tbody>
          </table>
        </div>
      </div>
      <div class="modal-footer">
        <a href="DownloadPassbookServlet" class="btn btn-primary">Download</a>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- User Info Modal -->
<div class="modal fade" id="userInfoModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h5>User Information</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Mobile:</strong> <%= mobile %></p>
        <p><strong>Account No:</strong> <%= account_no %></p>
        <%
          // Fetch email and total from DB
          try {
              Connection conn = DBConnection.getConnection();
              PreparedStatement ps = conn.prepareStatement("SELECT email FROM user_details WHERE account_no=?");
              ps.setString(1, account_no);
              ResultSet rs = ps.executeQuery();
              if (rs.next()) {
        %>
          <p><strong>Email:</strong> <%= rs.getString("email") %></p>
        <%
              }
              ps = conn.prepareStatement("SELECT total FROM transactions WHERE account_no=? ORDER BY date DESC LIMIT 1");
              ps.setString(1, account_no);
              rs = ps.executeQuery();
              if (rs.next()) {
        %>
          <p><strong>Total Amount:</strong> ₹<%= rs.getDouble("total") %></p>
        <%
              }
              conn.close();
          } catch(Exception e) { e.printStackTrace(); }
        %>
      </div>
      <div class="modal-footer"><button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button></div>
    </div>
  </div>
</div>

<!-- Loan Modal -->
<div class="modal fade" id="loanModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h5>Loan Options</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <ul>
          <li><strong>Home Loan:</strong> 8.5% interest - Upto ₹50 Lakhs</li>
          <li><strong>Education Loan:</strong> 6.5% interest - Upto ₹20 Lakhs</li>
          <li><strong>Personal Loan:</strong> 11.0% interest - Upto ₹5 Lakhs</li>
        </ul>
        <button class="btn btn-primary" onclick="alert('Please visit our nearest branch with ID proof. Fill loan form and verify documents.')">Get Loan</button>
      </div>
    </div>
  </div>
</div>

<!-- Insurance Modal -->
<div class="modal fade" id="insuranceModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h5>Insurance Plans</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <ul>
          <li><strong>Life Insurance:</strong> Coverage upto ₹1 Cr</li>
          <li><strong>Health Insurance:</strong> Upto ₹25 Lakhs for family</li>
          <li><strong>Vehicle Insurance:</strong> Third-party & own damage</li>
        </ul>
        <button class="btn btn-primary" onclick="alert('Please visit our branch to apply for insurance. Fill required documents and select plan.')">Get Insurance</button>
      </div>
    </div>
  </div>
</div>

<!-- ATM Card Modal -->
<div class="modal fade" id="atmCardModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h5>ATM Card Details</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <p><strong>Card Type:</strong> Visa Debit Card</p>
        <p><strong>Card Limit:</strong> ₹50,000/day</p>
        <p><strong>Issued By:</strong> Bank Management System</p>
      </div>
    </div>
  </div>
</div>

<!-- Contact Us Modal -->
<div class="modal fade" id="contactModal" tabindex="-1">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header"><h5>Contact Us</h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button></div>
      <div class="modal-body">
        <p><strong>Toll-Free Number:</strong> 1800-123-4567</p>
        <p><strong>Email:</strong> support@bank.com</p>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>


</body>
</html>

