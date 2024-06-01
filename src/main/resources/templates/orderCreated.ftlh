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

        /* Стили для контейнера с информацией о созданном заказе */
        .order-created-container {
            max-width: 500px;
            margin: 40px auto;
            padding: 20px;
            background-image: url('https://gas-kvas.com/uploads/posts/2023-02/1675440806_gas-kvas-com-p-razmitii-fonovii-risunok-16.jpg');
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center; /* Центрируем текст и кнопку */
        }

        /* Стили для заголовка */
        .order-created-header {
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .back-to-main-page-btn {
            background-color: #5ca142;
            color: #fff;
            border: none;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            text-decoration: none; /* Удалите подчеркивание у ссылки */
        }

        .back-to-main-page-btn:hover {
            background-color: #23527c;
            color: #fff; /* Измените цвет текста на белый */
        }
    </style>

</head>
<body>

<#include "navbar.ftlh"> <!-- Подключение навигационной панели -->
<br><br>
<br><br>

<div class="order-created-container">
    <div class="d-flex justify-content-center flex-column">
        <h2 class="order-created-header">Order created!</h2>
        <a href="/" class="back-to-main-page-btn">Back to main page</a>
    </div>
</div>

</body>
</html>