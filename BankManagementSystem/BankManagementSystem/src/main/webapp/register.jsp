<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Register - Bank Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }

        .container {
            max-width: 400px; /* Reduced container width for smaller content */
            margin-top: 50px;
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn {
            width: 48%; /* Ensure buttons fit on the same line */
        }

        .btn-group {
            display: flex;
            justify-content: space-between;
        }

        .form-label {
            font-weight: bold;
            font-size: 14px; /* Reduced font size */
        }

        .form-control {
            border-radius: 4px;
            padding: 8px; /* Reduced padding for a smaller form */
            font-size: 14px; /* Reduced font size */
        }

        h2 {
            font-size: 20px; /* Reduced title size */
            color: #343a40;
        }

        img {
            max-width: 40px; /* Smaller image */
            margin-bottom: 15px;
        }

        .btn:hover {
            opacity: 0.9;
            transition: 0.3s;
        }

        .alert {
            font-size: 14px;
            padding: 10px;
            margin-top: 15px;
            border-radius: 5px;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
        }

        .text-center {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="text-center">
        <h2>Create New Account</h2>
    </div>
    <form action="RegisterServlet" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Full Name</label>
            <input type="text" class="form-control" name="name" required />
        </div>
        <div class="mb-3">
            <label for="mobile" class="form-label">Mobile Number</label>
            <input type="text" class="form-control" name="mobile" required />
        </div>
        <div class="mb-3">
            <label for="account_no" class="form-label">Account Number</label>
            <input type="text" class="form-control" name="account_no" required />
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email ID</label>
            <input type="email" class="form-control" name="email" required />
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" required />
        </div>
        
        <% String error = request.getParameter("error");
            if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <div class="btn-group">
            <button type="submit" class="btn btn-success">Submit</button>
            <a href="index.jsp" class="btn btn-secondary">Back to Login</a>
        </div>
    </form>
</div>
</body>
</html>
