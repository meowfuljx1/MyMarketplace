<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon" href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png" type="image/x-icon">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marketplace</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <style>
        .error {
            color: red;
            margin-top: 10px;
        }
        body {
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2021-02/1613374241_89-p-bezhevii-razmitii-fon-103.jpg');
            background-size: cover;
            background-repeat: no-repeat;
        }
        .container {
            max-width: 500px;
            margin: 40px auto;
            padding: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .registration-form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .registration-form label {
            margin-bottom: 10px;
        }
        .registration-form input[type="text"], .registration-form input[type="email"], .registration-form input[type="password"], .registration-form input[type="date"] {
            width: 100%;
            height: 40px;
            margin-bottom: 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .registration-form input[type="submit"] {
            width: 100%;
            height: 40px;
            background-color: #4CAF50;
            color: #fff;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .registration-form input[type="submit"]:hover {
            background-color: #3e8e41;
        }
        .registration-form h4 {
            margin-top: 0;
            text-align: center;
        }
    </style>
</head>
<body>
<#include "navbarShortened.ftlh"> <!-- Подключение навигационной панели -->

<div class="container">
    <form class="registration-form" action="/waiting-for-activation" method="post">
        <h4>Registration</h4>
        <#if error??>
            <div class="error text-center text-danger">${error}</div>
        </#if> <br>
        <label for="name">Name:</label>
        <input type="text" name="name" id="name" required><br><br>

        <label for="dateOfBirth">Date of Birth:</label>
        <input type="date" id="dateOfBirth" name="dateOfBirth" required><br><br>

        <label for="city">City:</label>
        <input type="text" name="city" id="city" required><br><br>

        <label for="phoneNumber">Phone number:</label>
        <input type="text" name="phoneNumber" id="phoneNumber" required><br><br>

        <label for="telegram">Telegram:</label>
        <input type="text" name="telegram" id="telegram" required><br><br>

        <label for="email">Email:</label>
        <input type="email" name="email" id="email" required><br><br>

        <label for="password">Password:</label>
        <input type="password" name="password" id="password" required><br><br>

        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="submit" value="Sign up">
    </form>
</div>
</body>
</html>