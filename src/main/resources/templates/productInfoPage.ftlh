<!doctype html>
<html lang="en">
<head>
    <link rel="shortcut icon"
          href="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/16/Cat-Face-Flat-icon.png"
          type="image/x-icon">
    <meta charset="UTF-8">
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
                                    <form method="post" action="/add-to-cart">
                                        <input type="hidden" name="productId" value="${product.id}">
                                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                                        <input type="hidden" name="template" value="/product/${product.id}">
                                        <button type="submit" class="btn btn-warning mx-1">Add to cart</button>
                                    </form>
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
</body>
</html>