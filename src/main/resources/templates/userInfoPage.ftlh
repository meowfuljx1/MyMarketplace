<!DOCTYPE html>
<html>
<head>
    <link rel="shortcut icon"
          href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png"
          type="image/x-icon">
    <meta name="_csrf" content="${_csrf.token}"/>
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
                        <#if (user.email??) && (product.user.id != user.id) && !(product.order??)>
                            <#if product.shoppingCart??>
                                <a href="/show-shopping-cart" class="btn btn-warning btn-sm" style="height: 38px;">Go
                                    to</a>
                            <#else>
                            <#--<form method="post" action="/add-to-cart">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <input type="hidden" name="template" value="/seller/${seller.id}">
                                <button type="submit" class="btn btn-warning mx-1">Add to cart</button>
                            </form>-->

                                <button class="btn btn-warning mx-1" style="height: 38px;" id="addToCartButton"
                                        onclick="addToCartFunc(${product.id}, this)">Add to cart
                                </button>
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
<script>
    function addToCartFunc(product, button) {
        // обработка в зависимости от Add to cart и Go to
        if (button.innerText === 'Add to cart') {
            addToCartPostRequest(product)
            changeAddToCartBtn(button)
            changeCartCount()
        } else window.location.href = '/show-shopping-cart';
    }

    // post запрос на добавление товара в корзину
    function addToCartPostRequest(product) {
        const jsonData = {
            productId: product
        };
        const jsonString = JSON.stringify(jsonData);
        console.log('json string: ', jsonString)
        const xhr = new XMLHttpRequest();
        xhr.open('POST', 'http://localhost:8080/add-to-cart', true);
        const csrfToken = document.querySelector("meta[name='_csrf']").getAttribute("content");
        console.log('csrf token: ', csrfToken)
        xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
        xhr.setRequestHeader('Content-Type', 'application/json');
        xhr.send(jsonString);
    }

    function changeAddToCartBtn(button) {
        // изменение кнопки Add to cart на Go to
        button.innerText = 'Go to';

        button.classList.remove('btn');
        button.classList.remove('btn-warning');
        button.classList.remove('mx-1');

        button.classList.add('btn');
        button.classList.add('btn-warning');
        button.classList.add('btn-sm');
    }

    //изменение числа товаров в корзине
    function changeCartCount() {
        // кнопка shopping cart
        const cartBtn = document.getElementById('shoppingCartButton');
        // +1 к списку товаров
        let count = parseInt(cartBtn.innerText.replace(/\D/g, ''), 10) + 1;
        // обновление числа товаров
        cartBtn.innerText = `Shopping cart (` + count + ')';
    }
</script>
</body>
</html>