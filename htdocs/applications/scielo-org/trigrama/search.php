<?php
require_once(dirname(__FILE__)."/../../../php/include.php");//BVS SITE Includes
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes
include_once(dirname(__FILE__)."/../classes/services/TrigramaSimilar.php");

if($def['LETTER_UNIT'] != null){
        $baseDir = $def['LETTER_UNIT'].$def['DATABASE_PATH'];
}else{
        $baseDir = $def['DATABASE_PATH'];
}

$expression = $_REQUEST['expression'];
$place = split("\|",$_REQUEST["where"]);
$instanceCode = $place[1];
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

            $TrigramaSimilar = new TrigramaSimilar();
            $TrigramaSimilar->addParam("text",$expression);
            $TrigramaSimilar->addParam('collection','SciELO.'.$instanceCode.'.TiKwAb');
            $TrigramaSimilar->setXML();
            $xmlh = $TrigramaSimilar->getXML();
            $xslFile = realpath(dirname(__FILE__) . "/..")."/xsl/similar.xsl";
            $xml = "<root>";
            $xml .= "<vars>";
            $xml .= "<DIR>".SITE_DOMAIN."</DIR>";
            $xml .= "<PATH>file://".SITE_PATH."</PATH>";
            if (SITE_DOMAIN==SITE_CONTROLER){
                    $xml .= "<scielo-portal>yes</scielo-portal>";
            }
            $xml .= "<lang>".$lang."</lang>";
            $xml .= "<letter>".$letter."</letter>";
            $xml .= "<subject>".$subject."</subject>";
            $xml .= "<instance>".$instance."</instance>";
            $xml .= "<collection>".$collection."</collection>";
            $xml .= "<expression>".$expression."</expression>";
            $xml .= "</vars>";
            if (strpos(strtolower($xmlh), 'utf-8')){
                    $xmlh = $xmlh;
                    $xmlh = str_replace('<?xml version="1.0" encoding="utf-8"?>','',$xmlh);
                    $xmlh = str_replace('<?xml version="1.0" encoding="UTF-8"?>','',$xmlh);
            }else{
                    $xmlh = str_replace('<?xml version="1.0" encoding="ISO-8859-1"?>','',$xmlh);
                    $xmlh = str_replace('<?xml version="1.0" encoding="ISO-8859-1" ?>','',$xmlh);
            }
            $xml .= $xmlh;
            $xml .= "</root>";
            echo transformer($xml,$xslFile);
            ?>
            </div>
        </div>
    </body>
    <?
    if ( $def['GOOGLE_ANALYTICS_ID'] != ''){
    ?>
        <!-- Google analytics -->
        <script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
        <script type="text/javascript">
            _uacct = "<?=$def['GOOGLE_ANALYTICS_ID']?>";
            urchinTracker();
        </script>
    <?}?>
</html>