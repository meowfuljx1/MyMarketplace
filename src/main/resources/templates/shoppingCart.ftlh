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

    <h3 id="noProductsMsg" class="text-center" style="display: none;">There are no products yet</h3>

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
                    <tr id="row_${product.id}">
                        <td class="text-center">${product.title}</td>
                        <td class="text-center">${product.description}</td>
                        <td class="text-center">
                            <img src="data:image/jpeg;base64,${product.previewImg}" class="img-fluid"
                                 alt="Product image" style="max-width: 400px; height: 200px;">
                        </td>
                        <td class="text-center">${product.price} руб.</td>
                        <td class="text-center" style="width: 150px;">
                            <a href="/product/${product.id}" class="btn btn-primary mb-2" style="height: 38px;">More
                                details...</a>

                            <#--<form method="post" action="/delete-from-cart">
                                <input type="hidden" name="productId" value="${product.id}">
                                <input type="hidden" name="_csrf" value="${_csrf.token}">
                                <button type="submit" class="btn btn-danger" style="height: 38px;">Delete</button>
                            </form>-->

                            <button class="btn btn-danger" style="height: 38px;"
                                    onclick="deleteFromCartFunc(${product.id})">Delete
                            </button>

                        </td>
                    </tr>
                </#list>
                </tbody>
            </table>
        </div>

        <div class="text-center mt-3">
            <span id="orderSumRow">Order sum: ${cart.sum} руб.</span>
            <form id="orderCreateForm" method="post" action="/order/create">
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <button type="submit" class="btn btn-primary">Create an order</button>
            </form>
        </div>
    </#if>
</div>

<script>
    function deleteFromCartFunc(id) {
        // post запрос на удаление и обновление суммы корзины
        deleteFromCartRequest(id)
            .then(response => {
                const cartSize = response.cartSize;
                if (cartSize === 0){
                    document.querySelector('.table-responsive').style.display = 'none';
                    document.querySelector('#orderSumRow').style.display = 'none';
                    document.querySelector('#orderCreateForm').style.display = 'none';

                    // Отображаем сообщение о том, что нет товаров
                    document.querySelector('#noProductsMsg').style.display = 'block';
                }
                else {
                    const newSum = response.newSum;
                    console.log('New sum digit: ', newSum);
                    // обновление суммы корзины
                    let orderSumRow = document.getElementById('orderSumRow')
                    console.log('orderSumRow : ', orderSumRow.innerText)
                    orderSumRow.innerText = 'Order sum: ' + newSum + ' руб.'

                    // Скрываем сообщение о том, что нет товаров
                    document.querySelector('#noProductsMsg').style.display = 'none';
                }
            })
            .catch(error => {
                console.error('Ошибка:', error);
            });

        // удаление строки товара
        const row = document.getElementById('row_' + id);
        row.parentNode.removeChild(row);


    }

    function deleteFromCartRequest(id) {
        return new Promise((resolve, reject) => {
            // запрос
            const jsonData = {
                productId: id
            };
            const jsonString = JSON.stringify(jsonData);
            const xhr = new XMLHttpRequest();
            xhr.open('POST', 'http://localhost:8080/delete-from-cart', true);
            const csrfToken = document.querySelector("meta[name='_csrf']").getAttribute("content");
            xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken);
            xhr.setRequestHeader('Content-Type', 'application/json');

            // обработчик события изменения состояния запроса
            xhr.onreadystatechange = function () {
                // Проверяем, что запрос завершен
                if (xhr.readyState === XMLHttpRequest.DONE) {
                    // Проверяем, что статус ответа успешный (status === 200)
                    if (xhr.status === 200) {
                        changeCartCount()
                        // Получаем ответ от сервера в виде строки и парсим его в объект JSON
                        const response = JSON.parse(xhr.responseText);
                        resolve(response); // Возвращаем новую сумму через resolve
                    } else {
                        reject('Ошибка при получении ответа от сервера');
                    }
                }
            };
            xhr.send(jsonString);
        });
    }

    //изменение числа товаров в корзине
    function changeCartCount() {
        // кнопка shopping cart
        const cartBtn = document.getElementById('shoppingCartButton');
        // +1 к списку товаров
        let count = parseInt(cartBtn.innerText.replace(/\D/g, ''), 10) - 1;
        // обновление числа товаров
        cartBtn.innerText = `Shopping cart (` + count + ')';
    }

</script>

</body>
</html>
