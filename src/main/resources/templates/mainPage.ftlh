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

        /* Стили для фона карточек с продуктами */
        .card {
            background-image: url('https://gas-kvas.com/uploads/posts/2023-02/1675440806_gas-kvas-com-p-razmitii-fonovii-risunok-16.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            border: 2px solid #333; /* Темная рамка толщиной 2 пикселя */
        }

        h4 {
            color: white; /* Заголовок белый */
        }

        .btn-outline-success {
            background-color: #32CD32; /* Зеленая заливка */
            border-color: #32CD32; /* Зеленая рамка */
            color: #FFFFFF; /* Белый текст */
        }

        .btn-outline-success:hover {
            background-color: #228B22; /* Темно-зеленая заливка при наведении */
            border-color: #228B22; /* Темно-зеленая рамка при наведении */
        }
    </style>

</head>
<body>

<#include "navbar.ftlh"> <!-- Подключение навигационной панели -->

<br><br>

<div class="container mt-5 text-center">
    <h1 class="mb-4">Products from all over the world</h1>
    <form class="form-inline justify-content-center my-4">
        Site search: <span class="mr-2"></span><input class="form-control mr-sm-2" type="search" placeholder="Search"
                                                      aria-label="Search" name="title" value="${title}">
        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
    </form>
    <div class="row">
        <#list products as product>
            <#if !(user.email??) || ((product.user.id != user.id) && !(product.order??))>
                <div class="col-md-4 mb-4">
                    <div class="card h-100">
                        <div class="card-body">
                            <img src="data:image/jpeg;base64,${product.previewImg}" class="img-fluid"
                                 alt="Product image"
                                 style="width:  400px;height: 250px;">
                            <h5 class="card-title">${product.title}</h5>
                            <p class="card-text">${product.price} руб.</p>
                            <div class="btn-group">
                                <a href="/product/${product.id}" class="btn btn-primary mb-2 mr-2"
                                   style="height: 38px;">More
                                    details...</a>
                                <#if user.email??>
                                        <#if product.shoppingCart??>
                                            <a href="/show-shopping-cart" class="btn btn-warning btn-sm"
                                               style="height: 38px;">Go to</a>
                                        <#else>
                                            <form method="post" action="/add-to-cart">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                                <input type="hidden" name="template" value="/">
                                                <button type="submit" class="btn btn-warning mx-1">Add to cart</button>
                                            </form>
                                        </#if>
                                </#if>
                            </div>
                        </div>
                    </div>
                </div>
            </#if>
        </#list>
    </div>

    <#if products?size == 0>
        <h3>There are no products yet</h3>
    </#if>
</div>
</body>
</html>