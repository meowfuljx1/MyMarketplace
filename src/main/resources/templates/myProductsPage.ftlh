<!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon" href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png" type="image/x-icon">
    <title>Marketplace</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        /* Стили для фона страницы */
        body {
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2021-02/1613374241_89-p-bezhevii-razmitii-fon-103.jpg');
            background-size: cover;
            background-repeat: no-repeat;
        }
        /* Стили для фона таблицы */
        .table-custom {
            background-image: url('https://gas-kvas.com/uploads/posts/2023-02/1675440806_gas-kvas-com-p-razmitii-fonovii-risunok-16.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            border: 2px solid #333; /* Темная рамка толщиной 2 пикселя */
        }
        /* Стили для границ ячеек таблицы */
        .table-custom th,
        .table-custom td {
            border: 1px solid #333; /* Темные границы ячеек */
            padding: 0.5rem; /* Отступ вокруг текста */
        }
        /* Стили для первой строки таблицы */
        .table-custom thead tr:first-child th {
            background-color: #333; /* Цвет фона для первой строки */
            color: white; /* Цвет текста для первой строки */
            border-top: none; /* Убираем верхнюю границу у первой строки */
        }
        /* Стили для текста "There are no products yet" */
        .no-products {
            color: #333; /* Темный цвет текста */
            text-align: center; /* Текст по центру */
            margin-top: 50px; /* Отступ сверху */
        }

    </style>
</head>
<body>
<#include "navbar.ftlh"> <!-- Подключение навигационной панели -->
<div class="container">
    <br><br>
    <h1 class="text-center my-4">My products</h1>

    <#if user.products?size == 0>
        <h3 class="no-products">There are no products yet</h3>
    <#else>
        <table class="table table-custom">
            <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>City</th>
                <th>Price</th>
                <th>Image</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <#list user.products as product>
                <tr>
                    <td class="text">${product.title}</td>
                    <td class="text">${product.description}</td>
                    <td class="text">${product.city}</td>
                    <td class="text">${product.price}</td>
                    <td class="text-center">
                        <img src="data:image/jpeg;base64,${product.previewImg}" class="img-fluid" alt="Product image" style="max-width: 400px; height: 200px;">
                    </td>
                    <td style="white-space:nowrap">
                        <a href="/product/change/${product.id}" class="btn btn-primary mb-2">Edit</a>
                        <form method="POST" action="/product/delete/${product.id}">
                            <input type="hidden" name="_csrf" value="${_csrf.token}">
                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                    </td>
                </tr>
            </#list>
            </tbody>
        </table>
    </#if>
</div>
</body>
</html>
