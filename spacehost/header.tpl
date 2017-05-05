<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="{$charset}" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>

    {include file="$template/includes/head.tpl"}

    {$headoutput}

</head>
<body>
{if $adminMasqueradingAsClient}
    <!-- Return to admin link -->
    <div class="container-fluid admin-message">
        <div class="row">
            <div class="col-xs-12">
                <div class="alert admin-masquerade-notice">
                    {$LANG.adminmasqueradingasclient} <a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="alert-link">{$LANG.logoutandreturntoadminarea}</a>
                </div>
            </div>
        </div>
    </div>
{elseif $adminLoggedIn}
    <!-- Return to admin link -->
    <div class="container-fluid admin-message">
        <div class="row">
            <div class="col-xs-12">
                <div class="alert admin-masquerade-notice">
                    {$LANG.adminloggedin} <a href="{$WEB_ROOT}/logout.php?returntoadmin=1" class="alert-link">{$LANG.returntoadminarea}</a>
                </div>
            </div>
        </div>
    </div>
{/if}
    
<div id="header-holder">
    <div class="bottom-gradiant"></div>
    <nav id="main-nav" class="navbar navbar-default navbar-full">
        <div class="container-fluid">
            <div class="container container-nav">
                <div class="row">
                    <div class="col-md-12">
                        <div class="navbar-header">
                            <button aria-expanded="false" type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs">
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                                <span class="icon-bar"></span>
                            </button>
                            <a href="{$WEB_ROOT}/index.php">
                                <img class="logo" src="{$WEB_ROOT}/templates/{$template}/images/logo.svg" alt="{$companyname}">
                            </a>
                        </div>
                        <div style="height: 1px;" role="main" aria-expanded="false" class="navbar-collapse collapse" id="bs">
                             <ul class="nav navbar-nav navbar-right">
                                {include file="$template/includes/navbar.tpl" navbar=$primaryNavbar}
                                {include file="$template/includes/navbar.tpl" navbar=$secondaryNavbar}
                                <li><a class="chat-button" href="#">Chat now</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </nav>
    {$headeroutput}

    <section id="header">
        <div class="container">

            <!-- Top Bar -->
            <div id="top-nav">
                <!-- Language -->
                {if $languagechangeenabled && count($locales) > 1}
                    <div class="pull-right nav">
                        <a href="#" class="quick-nav" data-toggle="popover" id="languageChooser"><i class="fa fa-language"></i> {$LANG.chooselanguage} <span class="caret"></span></a>
                        <div id="languageChooserContent" class="hidden">
                            <ul>
                                {foreach from=$locales item=locale}
                                    <li><a href="{$currentpagelinkback}language={$locale.language}">{$locale.localisedName}</a></li>
                                {/foreach}
                            </ul>
                        </div>
                    </div>
                {/if}
                <!-- Login/Account Notifications -->
                {if $loggedin}
                    <div class="pull-right nav">
                        <a href="#" class="quick-nav" data-toggle="popover" id="accountNotifications" data-placement="bottom" title="{lang key="notifications"}"><i class="fa fa-info"></i> {$LANG.notifications} ({$clientAlerts|count})</a>
                        <div id="accountNotificationsContent" class="hidden">
                            {foreach $clientAlerts as $alert}
                                <div class="clientalert text-{$alert->getSeverity()}">{$alert->getMessage()}{if $alert->getLinkText()} <a href="{$alert->getLink()}" class="btn btn-xs btn-{$alert->getSeverity()}">{$alert->getLinkText()}</a>{/if}</div>
                            {foreachelse}
                                <div class="clientalert text-success"><i class="fa fa-check-square-o"></i> {$LANG.notificationsnone}</div>
                            {/foreach}
                        </div>
                    </div>
                {else}
                    <div class="pull-right nav">
                        <a href="#" class="quick-nav" data-toggle="popover" id="loginOrRegister" data-placement="bottom"><i class="fa fa-user"></i> {$LANG.login}</a>
                        <div id="loginOrRegisterContent" class="hidden">
                            <form action="{if $systemsslurl}{$systemsslurl}{else}{$systemurl}{/if}dologin.php" method="post" role="form">
                                <div class="form-group">
                                    <input type="email" name="username" class="form-control" placeholder="{$LANG.clientareaemail}" required />
                                </div>
                                <div class="form-group">
                                    <div class="input-group">
                                        <input type="password" name="password" class="form-control" placeholder="{$LANG.loginpassword}" autocomplete="off" required />
                                        <span class="input-group-btn">
                                            <input type="submit" class="btn btn-primary" value="{$LANG.login}" />
                                        </span>
                                    </div>
                                </div>
                                <label class="checkbox-inline">
                                    <input type="checkbox" name="rememberme" /> {$LANG.loginrememberme} &bull; <a href="{$WEB_ROOT}/pwreset.php">{$LANG.forgotpw}</a>
                                </label>
                            </form>
                            {if $condlinks.allowClientRegistration}
                                <hr />
                                {$LANG.newcustomersignup|sprintf2:"<a href=\"$WEB_ROOT/register.php\">":"</a>"}
                            {/if}
                        </div>
                    </div>
                {/if}
                <!-- Shopping Cart -->
                <div class="pull-right nav">
                    <a href="{$WEB_ROOT}/cart.php?a=view" class="quick-nav"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs">{$LANG.viewcart} (</span><span id="cartItemCount">{$cartitemcount}</span><span class="hidden-xs">)</span></a>
                </div>
            </div>
        </div>
    </section>
    {if $templatefile == 'homepage'}
    <div id="top-content" class="container-fluid">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    {if $registerdomainenabled || $transferdomainenabled}
                    <div class="big-title">Find a space for you.<br>Start today.</div>
                    <div class="domain-search-holder">
                        <form id="domain-search" method="post" action="domainchecker.php">
                            <input id="domain-text" type="text" name="domain" placeholder="{$LANG.exampledomain}" />
                            {if $registerdomainenabled}
                            <span class="inline-button">
                                <input id="search-btn" type="submit" name="submit" value="{$LANG.search}" />
                            </span>
                            {/if}
                            {if $transferdomainenabled}
                            <span class="inline-button">
                                <input id="transfer-btn" type="submit" name="transfer" value="{$LANG.domainstransfer}" />
                            </span>
                            {/if}
                        </form>
                        <div class="captcha-holder">{include file="$template/includes/captcha.tpl"}</div>
                    </div>
                    {else}
                        <div class="toparea-space"></div>
                    {/if}
                </div>
                <div class="col-md-12">
                    <div class="arrow-button-holder">
                        <a href="{$WEB_ROOT}/cart.php?a=view">
                            <div class="arrow-icon">
                                <i class="sphst sphst-arrow-down"></i>
                            </div>
                            <div class="button-text">Go to plans</div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    {/if}
</div>

{if $templatefile == 'homepage'}
<div class="row-title-only container-fluid more-padding">
    <div class="container">
        <div class="row">
            <div class="row-title">Why you’ll be happy with Space Host?</div>
        </div>
    </div>
</div>
<div id="features" class="container-fluid">
    <div class="container">
        <div class="row">
            <div class="col-sm-6 col-md-3">
                <div class="feature-box">
                    <div class="feature-icon">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/feature1.svg" alt="">
                    </div>
                    <div class="feature-title">Site Bulilder</div>
                    <div class="feature-details">
                        <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
                        <h4>Site Bulilder</h4>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="feature-box">
                    <div class="feature-icon">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/feature2.svg" alt="">
                    </div>
                    <div class="feature-title">100% Uptime</div>
                    <div class="feature-details">
                        <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
                        <h4>100% Uptime</h4>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="feature-box">
                    <div class="feature-icon">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/feature3.svg" alt="">
                    </div>
                    <div class="feature-title">Fast Loaded</div>
                    <div class="feature-details">
                        <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
                        <h4>Fast Loaded</h4>
                    </div>
                </div>
            </div>
            <div class="col-sm-6 col-md-3">
                <div class="feature-box">
                    <div class="feature-icon">
                        <img src="{$WEB_ROOT}/templates/{$template}/images/feature4.svg" alt="">
                    </div>
                    <div class="feature-title">Upload files</div>
                    <div class="feature-details">
                        <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
                        <h4>Upload files</h4>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>
<div id="partners" class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="row-title">Trusted by the best</div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-12">
            <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem<br> accusantium</p>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="partners-slider">
                <div><img src="{$WEB_ROOT}/templates/{$template}/images/partner1.png" alt=""></div>
                <div><img src="{$WEB_ROOT}/templates/{$template}/images/partner2.png" alt=""></div>
                <div><img src="{$WEB_ROOT}/templates/{$template}/images/partner3.png" alt=""></div>
                <div><img src="{$WEB_ROOT}/templates/{$template}/images/partner4.png" alt=""></div>
                <div><img src="{$WEB_ROOT}/templates/{$template}/images/partner5.png" alt=""></div>
                <div><img src="{$WEB_ROOT}/templates/{$template}/images/partner6.png" alt=""></div>
                <div><img src="{$WEB_ROOT}/templates/{$template}/images/partner7.png" alt=""></div>
            </div>
        </div>
    </div>
</div>
<div id="more-features" class="container-fluid">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="row-title">What we offer?</div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-4">
                <div class="mfeature-box">
                    <div class="mfeature-title">Web Hosting</div>
                    <div class="mfeature-text bg-color1">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="mfeature-box">
                    <div class="mfeature-title">Web Design</div>
                    <div class="mfeature-text bg-color2">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium</div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="mfeature-box">
                    <div class="mfeature-title">Support</div>
                    <div class="mfeature-text bg-color3">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium</div>
                </div>
            </div>
            
        </div>
    </div>
</div>
{if $registerdomainenabled || $transferdomainenabled}
<div id="search-box" class="container-fluid">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <p>Ready?<br>
Let’s get strated.</p>
                <div class="domain-search-holder">
                    <form id="domain-search2" method="post" action="domainchecker.php">
                        <input id="domain-text2" type="text" name="domain" placeholder="{$LANG.exampledomain}" />
                        {if $registerdomainenabled}
                        <span class="inline-button">
                            <input id="search-btn2" type="submit" name="submit" value="{$LANG.search}" />
                        </span>
                        {/if}
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
{/if}
<div id="domain-pricing" class="container-fluid">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="row-title">What you will get with domain names?</div>
            </div>
        </div>
        <div class="row domain-lists-holder">
            <div class="col-sm-12">
                <div class="domain-pricing-holder">
                    <script language="javascript" src="feeds/domainpricing.php"></script>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row-title-only container-fluid">
    <div class="container">
        <div class="row">
            <div class="row-title">What people say about Space Host?</div>
        </div>
    </div>
</div>
<div id="testimonials" class="container-fluid">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <div class="testimonial-box right-img">
                    <div class="row">
                        <div class="col-xs-3 img-holder dot-color1"><img src="{$WEB_ROOT}/templates/{$template}/images/person1.jpg" alt=""></div>
                        <div class="col-xs-9">
                            <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-box right-img">
                    <div class="row">
                        <div class="col-xs-3 img-holder dot-color2"><img src="{$WEB_ROOT}/templates/{$template}/images/person2.jpg" alt=""></div>
                        <div class="col-xs-9">
                            <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="testimonials-title">Grow with us<br>
See results.</div>
            </div>
            <div class="col-md-4">
                <div class="testimonial-box left-img">
                    <div class="row">
                        <div class="col-xs-3 img-holder dot-color3"><img src="{$WEB_ROOT}/templates/{$template}/images/person3.jpg" alt=""></div>
                        <div class="col-xs-9">
                            <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium</p>
                        </div>
                    </div>
                </div>
                <div class="testimonial-box left-img">
                    <div class="row">
                        <div class="col-xs-3 img-holder dot-color4"><img src="{$WEB_ROOT}/templates/{$template}/images/person4.jpg" alt=""></div>
                        <div class="col-xs-9">
                            <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="message-with-link" class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <span class="text">Lorem ipsum dolor sit amet, consectetur adipiscing.</span> <a href="{$WEB_ROOT}/contact.php" class="button-bluegrey">Request a Demo</a><a href="{$WEB_ROOT}/register.php" class="button-purple">Create free account</a>
        </div>
    </div>
</div>
{/if}

{include file="$template/includes/verifyemail.tpl"}
<div id="main-body-holder" class="container-fluid {if $templatefile eq 'products'}pricing{/if}">
    <section id="main-body" class="container">

        <div class="row">
            {if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren())}
                {if $primarySidebar->hasChildren()}
                    <div class="col-md-9 pull-md-right">
                        {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}
                    </div>
                {/if}
                <div class="col-md-3 pull-md-left sidebar">
                    {include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}
                </div>
            {/if}
            <!-- Container for main page display content -->
            <div class="{if !$inShoppingCart && ($primarySidebar->hasChildren() || $secondarySidebar->hasChildren())}col-md-9 pull-md-right{else}col-xs-12{/if} main-content">
                {if !$primarySidebar->hasChildren() && !$showingLoginPage && !$inShoppingCart && $templatefile != 'homepage'}
                    {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}
                {/if}
