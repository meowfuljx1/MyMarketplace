<!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon"
          href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png"
          type="image/x-icon">
    <title>Marketplace</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
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
<div class="container">
    <br><br><br>
    <p class="text-center text-black display-4">Detailed information about seller</p>
    <p><b>Name:</b> ${seller.name}</p>
    <p><b>Phone number:</b> ${seller.phoneNumber}</p>
    <p><b>Telegram:</b> <a href="https://t.me/${seller.telegram?substring(1)}">${seller.telegram}</a></p>
    <p><b>City:</b> ${seller.city}</p>
</div>
<div class="container mt-5 text-center">
    <h4>Products</h4>
    <div class="row">
        <#list seller.products as product>
        <div class="col-md-4 mb-4">
            <div class="card h-100">
                <div class="card-body">
                    <img src="data:image/jpeg;base64,${product.previewImg}" class="img-fluid" alt="Product image"
                         style="width:  400px;height: 250px;">
                    <h5 class="card-title">${product.title}</h5>
                    <p class="card-text">${product.price} руб.</p>
                    <div class="btn-group">
                        <a href="/product/${product.id}" class="btn btn-primary mb-2 mr-2"  style="height: 38px;">More details...</a>
                        <#if (product.user.id != user.id) && !(product.order??)>
                            <#if product.shoppingCart??>
                                <a href="/show-shopping-cart" class="btn btn-warning btn-sm" style="height: 38px;">Go
                                    to</a>
                            <#else>
                                <form method="post" action="/add-to-cart">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <input type="hidden" name="template" value="/seller/${seller.id}">
                                    <button type="submit" class="btn btn-warning mx-1">Add to cart</button>
                                </form>
                            </#if>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        <#else>
    </div>
    <h3 class="text-muted">There are no products yet</h3>
    </#list>
</div>
</body>
</html>