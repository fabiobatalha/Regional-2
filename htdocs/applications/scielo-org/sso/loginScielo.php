<?
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title>SciELO.org - Scientific Electronic Library Online</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="Expires" content="-1" />
        <meta http-equiv="pragma" content="no-cache" />
        <meta name="robots" content="all" />
        <meta name="MSSmartTagsPreventParsing" content="true" />
        <meta name="generator" content="BVS-Site 4.0-rc4" />
        <link rel="stylesheet" href="/applications/scielo-org/css/public/print.css" type="text/css" media="print"/>
        <link rel="stylesheet" href="/applications/scielo-org/css/public/style-pt.css" type="text/css" media="screen"/>
        <style>
            .container {
                width: 760px;
                margin: 0 auto;
            }
            .login {
                width: 25%;
                float: right;
            }
            .intro {
                width: 75%;
                float: left;
                line-height: 150%;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="top">
                    <div id="parent"><img src="/applications/scielo-org/image/public/skins/classic/<?=$_REQUEST["lang"]?>/banner.jpg" alt="SciELO - Scientific Electronic Librery Online" /></div>
                <div id="identification">
                    <h1><span>SciELO.org - Scientific Electronic Library Online</span></h1>
                </div>
            </div>

            <div class="middle">
                <div class="intro">
                    <h4><?=FREE_REGISTRATION?></h4>
                    <p><?=FREE_REGISRATION_DESC?><br/><?if(SITE_HOTSITE != ""){?><a href="<?=SITE_HOTSITE?>?lang=<?=$_REQUEST["lang"]?>"><strong><?=LEARN_MORE?></strong></a><?}?></p>
                </div>
                <div class="login">
                    <iframe scrolling="no" frameborder="0" src="<?=SITE_DOMAIN?>/<?=RELATIVE_PATH_SERVPLAT?>/controller/requestauth/mode/scielo/origin/<?=base64_encode($_SERVER['HTTP_REFERER'])?>/lang/<?=$_REQUEST["lang"]?>/skin/scielo" name="platserv">&nbsp;</iframe>
                </div>

            </div>
        </div>
    </body>
</html>