<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - Bank Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: linear-gradient(to right, #e3f2fd, #ffffff);
            margin: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            font-size: 0.875rem;
        }

        .container {
            max-width: 340px;
            margin-top: 40px;
            background-color: #ffffff;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        .login-image-top {
            display: block;
            margin: 0 auto 10px auto;
            max-width: 70px;
            height: auto;
        }

        h2 {
            color: #007bff;
            font-weight: 600;
            text-align: center;
            margin-bottom: 20px;
            font-size: 1.2rem;
        }

        .form-label {
            font-weight: 600;
            font-size: 0.875rem;
        }

        .form-control {
            border-radius: 10px;
            font-size: 0.875rem;
        }

        .btn-container {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .btn-primary, .btn-secondary {
            width: 100%;
            padding: 10px;
            border-radius: 8px;
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
            transform: scale(1.03);
        }

        .btn-secondary {
            background-color: #6c757d;
            border-color: #6c757d;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
            border-color: #5a6268;
            transform: scale(1.03);
        }

        .btn-link {
            color: #007bff;
            font-weight: bold;
            font-size: 0.8rem;
        }

        .btn-link:hover {
            text-decoration: underline;
            color: #0056b3;
        }

        .alert-danger {
            border-radius: 10px;
            background-color: #f8d7da;
            border-color: #f5c6cb;
            font-size: 0.85rem;
        }

        .modal-content {
            border-radius: 10px;
        }

        .modal-header {
            background-color: #007bff;
            color: white;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }

        .modal-footer {
            border-bottom-left-radius: 10px;
            border-bottom-right-radius: 10px;
        }

        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 0.25rem rgba(38, 143, 255, 0.5);
        }

        @media (max-width: 576px) {
            .container {
                margin-top: 30px;
            }
        }
    </style>
</head>
<body>
<div class="container">

    <img src="images/b.png" alt="Bank Logo" class="login-image-top">

    <h2>Bank Management System - Login</h2>

    <form action="LoginServlet" method="post" class="">
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" name="name" required/>
        </div>
        <div class="mb-3">
            <label for="mobile" class="form-label">Mobile</label>
            <input type="text" class="form-control" name="mobile" required/>
        </div>
        <div class="mb-3">
            <label for="account_no" class="form-label">Account Number</label>
            <input type="text" class="form-control" name="account_no" required/>
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" name="email" required/>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" name="password" required/>
        </div>

        <% String error = request.getParameter("error");
           if (error != null) { %>
           <div class="alert alert-danger"><%= error %></div>
        <% } %>

        <div class="btn-container">
            <button type="submit" class="btn btn-primary">Login</button>
            <a href="register.jsp" class="btn btn-secondary">Create Account</a>
        </div>

        <div class="text-center mt-3">
            <button type="button" class="btn btn-link" data-bs-toggle="modal" data-bs-target="#forgotPasswordModal">
                Forgot Password?
            </button>
        </div>
    </form>
</div>

<div class="modal fade" id="forgotPasswordModal" tabindex="-1" aria-labelledby="forgotPasswordModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="forgotPasswordModalLabel">Forgot Password</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <p>Please visit our nearest bank branch to reset your password.</p>
        <h6>Steps to change password:</h6>
        <ol>
          <li>Visit any authorized branch with a valid ID.</li>
          <li>Request a password reset form.</li>
          <li>Fill out the form and verify your account.</li>
          <li>Our staff will assist in setting your new password.</li>
        </ol>
        <p>If you have any questions, contact support at <strong>support@bank.com</strong></p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Okay</button>
      </div>
    </div>
  </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>