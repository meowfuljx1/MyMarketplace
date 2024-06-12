<!doctype html>
<html lang="en">
<head>
    <link rel="shortcut icon"
          href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png"
          type="image/x-icon">
    <meta charset="UTF-8">
    <meta name="_csrf" content="${_csrf.token}"/>
    <title>Marketplace</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
    <style>
        body {
            background-image: url('https://catherineasquithgallery.com/uploads/posts/2021-02/1613374241_89-p-bezhevii-razmitii-fon-103.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            color: #000000; /* Текст синий */
            font-family: sans-serif; /* Шрифт по умолчанию */
            font-size: 18px; /* Размер шрифта 18px */
        }

        h4 {
            color: #15151f; /* Заголовок синий */
            font-size: 24px; /* Размер заголовка 24px */
        }
    </style>
</head>
<body>
<#include "navbar.ftlh"> <!-- Подключение навигационной панели -->
<div class="container">
    <br><br>
    <br><br>
    <h4 class="text-center">Detailed information about the product</h4>

    <div class="row">
        <#list product.images as img>
            <div class="col-md-4 mb-4">
                <img src="data:image/jpeg;base64,${img}" class="img-fluid" alt="Product image"
                     style="width: 400px;height: 300px;">
            </div>
        </#list>
    </div>
    <div class="row">
        <div class="col-md-12">
            <b>Title: </b>${product.title}<br>
            <b>Description: </b>${product.description}<br>
            <b>Price: </b>${product.price}<br>
            <b>City: </b>${product.city}<br>
            <b>Author: </b><a href="/seller/${product.user.id}">${product.user.name}</a><br>

            <#if user.email??>

                <table style="table-layout: fixed;">
                    <tr>
                        <#if user.id == product.user.id>
                            <td>
                                <a href="/product/change/${product.id}" class="btn btn-primary">Edit</a>
                            </td>
                            <td style="white-space:nowrap">
                                <form method="POST" action="/product/delete/${product.id}">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <button type="submit" class="btn btn-danger"
                                            onclick="return confirm('Are you sure?')">
                                        Delete
                                    </button>
                                </form>
                            </td>
                        </#if>

                        <#if (product.user.id != user.id) && !(product.order??)>
                            <td>
                                <#if product.shoppingCart??>
                                    <a href="/show-shopping-cart" class="btn btn-warning btn-sm" style="height: 38px;">Go
                                        to</a>
                                <#else>
                                    <button class="btn btn-warning mx-1" style="height: 38px;" id="addToCartButton"
                                            onclick="addToCartFunc(${product.id}, this)">Add to cart
                                    </button>
                                </#if>
                            </td>
                        </#if>
                    </tr>
                </table>
            </#if>

        </div>
    </div>
    <hr>
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