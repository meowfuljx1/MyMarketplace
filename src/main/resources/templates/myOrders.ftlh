<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon"
          href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png"
          type="image/x-icon">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Marketplace</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        /* Стили для фона страницы */
        body {
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2021-02/1613374241_89-p-bezhevii-razmitii-fon-103.jpg');
            background-size: cover;
            background-repeat: no-repeat;
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
<br><br><br>
<h1 class="text-center">My orders</h1>
<#if user.orders?size == 0>
<h3 class="text-center">There are no products yet</h3>
<#else>
<div class="container mt-5 text-center">
    <div class="container">
        <div class="row">
            <#list user.orders as order>
                <div class="col-md-4">
                    <div class="card mb-4">
                        <h5 class="card-header">Order #${order.id}, Amount: ${order.sum} руб.</h5>
                        <div class="card-body">
                            <ul>
                                <#list order.products as product>
                                    <li>
                                        <strong>${product.title}</strong> - ${product.price} руб.
                                    </li>
                                </#list>
                            </ul>
                            <form method="post" action="/my-orders/cancel/${order.id}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button type="submit" class="btn btn-danger">Cancel the order</button>
                            </form>
                        </div>
                    </div>
                </div>
            </#list>
        </div>
    </div>
    </#if>
</div>
</body>
</html>