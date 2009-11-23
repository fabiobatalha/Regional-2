<?
require_once(dirname(__FILE__)."/../../../php/include.php");//BVS SITE Includes
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes

if($def['LETTER_UNIT'] != null){
        $baseDir = $def['LETTER_UNIT'].$def['DATABASE_PATH'];
}else{
        $baseDir = $def['DATABASE_PATH'];
}
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title>
            <?=SITE_NAME?>
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="Expires" content="-1"/>
        <meta http-equiv="pragma" content="no-cache"/>
        <meta name="author" content="BIREME (http://www.bireme.br/)"/>
        <meta name="keywords" content="information, health, bibliography, library, knowledge, health information, virtual library"/>
        <meta name="description" content="Virtual Health Library - Information and Knowledge"/>
        <meta name="robots" content="all" />
        <meta name="MSSmartTagsPreventParsing" content="true" />
        <link rel="shortcut icon" href="<?=$def['DIRECTORY']?>favicon.ico"/>
        <link rel="stylesheet" href="/applications/scielo-org/css/public/print.css" type="text/css" media="print"/>
        <link rel="stylesheet" href="/applications/scielo-org/css/public/style-<?=$checked['lang']?>.css" type="text/css" media="screen"/>
    </head>
    <body>
        <div class="container">
            <div class="level2">
            <?
            $html = file_get_contents($baseDir."/html/" . $lang . "/bvs.html");
            echo utf8_encode($html);
            ?>
                <div class="middle">
                    <div id="breadCrumb">
                        <a href="/" target="_parent">home </a> &gt; iAH
                    </div>
                    <div class="content">
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>