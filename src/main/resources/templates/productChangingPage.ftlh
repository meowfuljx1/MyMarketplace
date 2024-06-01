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
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2023-02/1676612706_catherineasquithgallery-com-p-temno-zelenii-razmitii-fon-61.jpg');
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
        .card {
            background-image: url('https://gas-kvas.com/uploads/posts/2023-02/1675440806_gas-kvas-com-p-razmitii-fonovii-risunok-16.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            border: 2px solid #333; /* Темная рамка толщиной 2 пикселя */
        }
    </style>
</head>
<body>
<#include "navbar.ftlh"> <!-- Подключение навигационной панели -->
<div class="container">
    <div class="row">
        <div class="col-md-6 offset-md-3 product-form">
            <br><br>
            <h3>Edit product</h3>
            <#if msg??>
                <p style="font-size: 24px; color: red; text-align: center;">${msg}</p>
            </#if>
            <form action="/product/update" method="post" enctype="multipart/form-data">
                Title: <input type="text" name="title" value="${product.title}" required /><br><br>
                Description: <input type="text" name="description" value="${product.description}" required /><br><br>
                Price: <input type="number" name="price" value="${product.price}" required><br><br>
                City: <input type="text" name="city"  value="${product.city}" required /><br><br>
                <input type="hidden" name="productId" value="${product.id}">
                <div class="row">
                <#list product.images as img>
                    <div class="col-md-4">
                        <img src="data:image/jpeg;base64,${img}" class="img-fluid" alt="Product image" style="width: 200px;height: 100px;">
                    </div>
                </#list>
                </div>
                <br>
                <!-- Поля для выбора файлов с индексированными именами -->
                Выбрать другие изображения:
                <input type="file" name="files" multiple /><br><br>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <input type="submit" value="Save product" />
            </form>
        </div>
    </div>
</div>
</body>
</html>