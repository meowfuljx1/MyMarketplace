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
        .error {
            color: red;
            margin-top: 10px; /* Добавьте отступ сверху, если нужно */
        }
        .msg {
            color: #0e8631;
            margin-top: 10px; /* Добавьте отступ сверху, если нужно */
        }
    </style>

</head>
<body>
<div class="container text-center">
    <#if error??>
        <div class="error text-center text-danger">${error}</div>
    <#else>
           <div class="msg text-center"><h2>${msg}</h2></div>
    </#if>
    <h2>You can close this page.</h2>
    <img src="https://steamuserimages-a.akamaihd.net/ugc/2011453778836784523/83AA6707CF1C927BEE0FDAF23AE59DEF512740B1/?imw=512&amp;imh=583&amp;ima=fit&amp;impolicy=Letterbox&amp;imcolor=%23000000&amp;letterbox=true" alt="Cat image" class="img-fluid mb-4">
</div>
</body>
</html>