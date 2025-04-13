<%-- 
    Document   : addmoney
    Created on : 12-Apr-2025, 2:08:49 pm
    Author     : Rahul Kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page session="true" %>
<%
    String account_no = (String) session.getAttribute("account_no");
    if (account_no == null) {
        response.sendRedirect("index.jsp?error=Please+login+first");
        return;
    }
    String error = request.getParameter("error");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Add Money</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container mt-5">
        <div class="text-center mb-4">
            <h2 class="fw-bold text-success">Add Money</h2>
        </div>

        <% if (error != null) { %>
            <div class="alert alert-danger text-center">
                <%= error %>
            </div>
        <% } %>

        <div class="card shadow p-4">
            <form action="AddMoneyServlet" method="post">
                <div class="mb-3">
                    <label for="amount" class="form-label fw-semibold">Enter Amount</label>
                    <input type="number" class="form-control" name="amount" id="amount" min="0" placeholder="e.g. 100">
                </div>
                <div class="d-flex justify-content-between">
                    <button type="submit" class="btn btn-success px-4">Add</button>
                    <a href="userdetails.jsp" class="btn btn-secondary">Back to Dashboard</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>

