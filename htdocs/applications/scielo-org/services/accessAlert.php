<?
require_once(dirname(__FILE__).'/../includes/include.php');
require_once(dirname(__FILE__).'/../../../apps/servicesplatform/client/config.php');

$docID = $_REQUEST["PID"];
$userTK = $_SESSION["userTK"];
$docURL = $_REQUEST["url"];
$domain = str_replace("http://","",$docURL);
$domain = substr($domain,0,strpos($domain,"/"));
$docURL = "http://".$domain."/scielo.php?script=sci_arttext&amp;pid=".$docID."&amp;lng=es&amp;nrm=iso&amp;tlng=pt";

//Geting article metadata
$articleMetadataURL = str_replace("#SOURCE_DOMAIN#",$domain,SCIELO_ARTICLE_METADATA).$docID;
$articleMetadataXML = file_get_contents($articleMetadataURL);

/* Parsing article XML to get Article title and authors */
$xml = simplexml_load_string($articleMetadataXML);
if($xml){
    $arrArticle = array();
    foreach($xml->ARTICLE as $articleElem){
        foreach($articleElem->TITLES->TITLE as $titleOcc){
            if ($titleOcc['LANG'] == "en"){
                $article["title"] = (String) $titleOcc;
                break;
            }else{
                $article["title"] = (String) $titleOcc;
            }
        }
        foreach($articleElem->AUTHORS->AUTH_PERS->AUTHOR as $authorOcc){
            $article["authors"] .= (String) $authorOcc->NAME.", ".$authorOcc->SURNAME."; ";
        }
        $article["authors"] = substr($article["authors"],0,strlen($article["authors"])-2);
        $titleReplace = array("<B>","</B>","<b>","</b>");
        $article["title"] = str_replace($titleReplace,"",$article["title"]);
    }
}
if($userTK){

    $objSoapClient = new SoapClient(null,array('location'=>SERVICES_PLATFORM_SERVER.'/DocsCollection.php',
                                                'uri'=>'http://test-uri/'));
    $docURL  = htmlspecialchars($docURL);
    $docID   =  htmlspecialchars($docID);
    $domain  =  htmlspecialchars($domain);
    $authors =  htmlspecialchars($article["authors"]);
    $title   =  htmlspecialchars($article["title"]);

$xmlDoc=<<<XML
<?xml version='1.0'?>
<docs>
        <doc>
        <field name="doc_id">{$docID}</field>
        <field name="doc_url">{$docURL}</field>
        <field name="src_id">{$domain}</field>
        <field name="au">{$authors}</field>
        <field name="title">{$title}</field>
    </doc>
</docs>
XML;

$retValue = $objSoapClient->addDoc($userTK,$xmlDoc);
if ($retValue){
    $retValue = $objSoapClient->enableAccessAlert($userTK,$docID);
}

if ($retValue){
    $message = ENABLE_ACCESS_ALERT_OK;
}else{
    $message = TRY_AGAIN_LATER;
}

}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="Pragma" content="no-cache" />
        <script type="text/javascript">
            function fecha(){
                self.close();
            }
            function delay(){
                setTimeout("fecha()", 500000);
            }
        </script>
    </head>
    <body onload="delay()">
    <div class="container">
        <div class="level2">
            <div class="top">
                <div id="parent">
                    <img src="<?=SITE_RELATIVE_PATH?>/image/public/skins/classic/<?=$lang?>/banner.jpg" />
                </div>
            </div>
        </div>
        <div class="middle">
            <div class="content">
                <p align="center"><?=$message?></p>
            </div>
        </div>
    </div>
    </body>
</html>