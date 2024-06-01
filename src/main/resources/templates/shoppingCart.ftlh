<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon" href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png" type="image/x-icon">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marketplace</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        /* Стили для фона страницы */
        body {
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2021-02/1613374241_89-p-bezhevii-razmitii-fon-103.jpg');
            background-size: cover;
            background-repeat: no-repeat;
        }

        /* Стили для таблицы */
        .table {
            background-image: url('https://gas-kvas.com/uploads/posts/2023-02/1675440806_gas-kvas-com-p-razmitii-fonovii-risunok-16.jpg'); /* замените на свой URL */
            background-size: cover;
            border: 1px solid black; /* изменяем цвет границ на черный */
            border-collapse: collapse; /* чтобы границы не дублировались */
        }

        .table th, .table td {
            border: 1px solid black; /* изменяем цвет границ на черный */
            padding: 10px; /* добавляем отступы для ячеек */
        }
    </style>

</head>
<body>
<#include "navbar.ftlh"> <!-- Подключение навигационной панели -->
<div class="container">
    <br><br><br>
    <h1 class="text-center">Shopping cart</h1>

    <#if cart.products?size == 0>
        <h3 class="text-center">There are no products yet</h3>
    <#else>
        <div class="table-responsive">
            <table class="table table-custom">
                <thead>
                <tr>
                    <th>Product</th>
                    <th>Description</th>
                    <th>Image</th>
                    <th>Price</th>
                    <th>Action</th> <!-- Добавлено новое поле "Action" -->
                </tr>
                </thead>
                <tbody>
                <#list cart.products as product>
                    <tr>
                        <td class="text-center">${product.title}</td>
                        <td class="text-center">${product.description}</td>
                        <td class="text-center">
                            <img src="data:image/jpeg;base64,${product.previewImg}" class="img-fluid" alt="Product image" style="max-width: 400px; height: 200px;">
                        </td>
                        <td class="text-center">${product.price} руб.</td>
                        <td class="text-center" style="width: 150px;"> <!-- Увеличиваем ширину колонки -->
                            <a href="/product/${product.id}" class="btn btn-primary mb-2" style="height: 38px;">More details...</a> <!-- Убираем mr-2 -->
                            <form method="post" action="/delete-from-cart">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button type="submit" class="btn btn-danger" style="height: 38px;">Delete</button>
                            </form>
                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-3">
            Order sum: ${cart.sum} руб.
            <form method="post" action="/order/create">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button type="submit" class="btn btn-primary">Create an order</button>
            </form>
        </div>
    </#if>
</div>

</body>
</html>
