<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon" href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png" type="image/x-icon">
    <meta charset="UTF-8">
    <title>Marketplace</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        /* Стили для фона страницы */
        body {
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2021-02/1613374241_89-p-bezhevii-razmitii-fon-103.jpg');
            background-size: cover;
            background-repeat: no-repeat;
        }
        /* Стили для формы создания товара */
        .product-form {
            max-width: 500px;
            margin: 0 auto;
            padding: 20px;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        .product-form h3 {
            text-align: center;
            margin-bottom: 30px;
        }
        .product-form label {
            display: block;
            margin-bottom: 10px;
        }
        .product-form input[type="text"],
        .product-form input[type="number"],
        .product-form input[type="file"] {
            width: 100%;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            margin-bottom: 20px;
        }
        .product-form input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .product-form input[type="submit"]:hover {
            background-color: #1e7e34;
        }
    </style>
</head>
<body>
<#include "navbar.ftlh"> <!-- Подключение навигационной панели -->
<div class="container">
    <div class="row">
        <div class="col-md-6 offset-md-3 product-form">
            <br><br>
            <h3>Add new product</h3>
            <#if msg??>
                <p style="font-size: 24px; color: red; text-align: center;">${msg}</p>
            </#if>
            <form action="/product/create" method="post" enctype="multipart/form-data">
                Title: <input type="text" name="title" required /><br><br>
                Description: <input type="text" name="description" required /><br><br>
                Price: <input type="number" name="price" required><br><br>
                City: <input type="text" name="city" required /><br><br>
                <!-- Поля для выбора файлов с индексированными именами -->
                Выберете несколько изображений к вашему товару:
                <input type="file" name="files" required multiple /><br><br>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Add product" />
            </form>
        </div>
    </div>
</div>
</body>
</html>