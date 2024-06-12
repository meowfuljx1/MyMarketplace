<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <a class="navbar-brand" href="/">
        <img src="https://icons.iconarchive.com/icons/microsoft/fluentui-emoji-flat/128/Cat-Face-Flat-icon.png" alt="Logo" width="48" height="48">
    </a>
    <a class="navbar-brand navbar-brand-large" href="/">Marketplace</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav mr-auto">
            <#--<#if user.isAdmin()>
                <li class="nav-item">
                    <a class="btn btn-info btn-sm" href="/admin" style="margin-right: 20px;">Admin panel</a>
                </li>
            </#if>-->
        </ul>
        <ul class="navbar-nav ml-auto navbar-btn-group">

            <#if user.email??>

                <li class="nav-item">
                    <a class="btn btn-success btn-sm" href="/product/new/creation-form">Add product</a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-info btn-sm" href="/my-products">My products</a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-sm" style="background-color: purple; color: white;" href="/my-orders">My orders</a>
                </li>

                <li class="nav-item">
                    <a id="shoppingCartButton" class="btn btn-warning btn-sm" href="/show-shopping-cart">Shopping cart (${user.shoppingCart.products?size})</a>
                </li>

                <h5 class="user-name"> ${user.name}</h5>
                <li class="nav-item">
                    <form action="/logout" method="post">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <input type="submit" value="Log out" class="btn btn-sm btn-outline-secondary" style="background-color: #e7346a; color: #fff;"/>
                    </form>
                </li>

            <#else>

                <li class="nav-item">
                    <a class="btn btn-success btn-sm" href="/login">Add product</a>
                </li>

                <li class="nav-item">
                    <a class="btn btn-success btn-sm" href="/login" style="background-color: #007bff; border-color: #007bff; color: #fff;">Log in</a>
                </li>

            </#if>

        </ul>
    </div>
</nav>
<style>
    .navbar {
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        z-index: 1000;
        height: 60px;
    }

    .navbar-brand-large {
        font-size: 24px;
    }

    .navbar-btn-group .nav-item {
        margin-left: 10px;
        margin-right: 10px;
    }
    .btn-info {
        color: #fff;
        background-color: #007bff;
        border-color: #007bff;
    }
    .user-name {
        color: #fff;
    }
</style>