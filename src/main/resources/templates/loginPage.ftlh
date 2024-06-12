<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon"
          href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png"
          type="image/x-icon">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Marketplace</title>
    <!-- Add Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <style>
        .form-container {
            max-width: 400px;
            margin: 0 auto;
        }

        .btn-half {
            width: 45%;
            margin: 0 auto;
            display: block;
            margin-bottom: 10px;
        }

        .error {
            color: red;
            margin-top: 10px; /* Добавьте отступ сверху, если нужно */
        }

        .msg {
            color: #39964a;
            margin-top: 10px; /* Добавьте отступ сверху, если нужно */
        }

        body {
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2021-02/1613374241_89-p-bezhevii-razmitii-fon-103.jpg');
            background-size: cover;
            background-repeat: no-repeat;
        }
    </style>
</head>
<body>
<#include "navbarShortened.ftlh"> <!-- Подключение навигационной панели -->

<div class="container">
    <br><br><br><br>
    <h4 class="text-center">Authorization</h4>

    <#if msg??>
        <div class="msg text-center">${msg}</div>
    <#elseif error??>
        <div class="error text-center text-danger">${error}</div>
    </#if>

    <div class="form-container">
        <form method="POST" action="/login">
            <div class="form-group">
                <label for="email">Email address:</label>
                <input type="email" class="form-control" id="email" name="username" placeholder="Enter email">
            </div>
            <div class="form-group">
                <label for="pwd">Password:</label>
                <input type="password" class="form-control" id="pwd" name="password" placeholder="Enter password">
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="btn btn-primary btn-half">Log in</button>
        </form>
        <a href="/registration" class="btn btn-secondary btn-half">Sign up</a>
    </div>
</div>
</body>
</html>