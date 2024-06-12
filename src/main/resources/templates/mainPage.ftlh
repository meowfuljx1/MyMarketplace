<!DOCTYPE html>
<html lang="en">
<head>
    <link rel="shortcut icon"
          href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png"
          type="image/x-icon">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="_csrf" content="${_csrf.token}"/>
    <title>Marketplace</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
    <style>
        /* Стили для фона страницы */
        body {
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2021-02/1613374241_89-p-bezhevii-razmitii-fon-103.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center center;
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
                                        <button class="btn btn-warning mx-1" style="height: 38px;" id="addToCartButton"
                                                onclick="addToCartFunc(${product.id}, this)">Add to cart
                                        </button>
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