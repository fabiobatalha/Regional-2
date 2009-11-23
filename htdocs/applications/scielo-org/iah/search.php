<?
ob_start();
require_once(dirname(__FILE__)."/../../../php/include.php");//BVS SITE Includes
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes

$q = str_replace('\"','%22',$_REQUEST['expression']);
$index = $_SERVER["HTTP_REFERER"];

$sourceRegional = IAHSOURCEREGIONAL;

$place = split("\|",$_POST["where"]);
$instanceCode = $place[1];
$instanceUrl = $place[0];

switch ($_POST["lang"]) {
    case "en":
        $lang="i";
    break;
    case "es":
        $lang="e";
    break;
    case "pt":
        $lang="p";
    break;
}

if ($instanceCode == "org"){
        $sourceRegional = SITE_DOMAIN;
}else{
    //Verifica se os indices do IAH utilizarao a fonte de indices do Regional ou da Instancia
    //on = regional; off = instancia
    if ($sourceRegional == true){
        $sourceRegional = SITE_DOMAIN;
    }else{
        $sourceRegional = SITE_DOMAIN;
    }

}
if (substr($_POST["url"],0,7)=='http://'){
    $destination = '';
} else {
    $destination = $sourceRegional;
}
if ($_POST["mode"] == "index"){
       $URL = $destination.str_replace("_param_","&",$_POST["url"])."&conectSearch=AND&form=F";
}else{
    if ($_POST["url_search"]){
        $URL = $_POST["url_search"];
        $URL = str_replace('REPLACE_BASE',$instanceCode,$URL);
        $URL = str_replace('REPLACE_EXPRESSION',$q,$URL);
        if ($instanceCode == "library") {
            $URL = str_replace('_param_rep=REPLACE_REP','',$URL);
        } else {
            $URL = str_replace('_param_rep=REPLACE_REP','_param_limit=rep=000'.substr($instanceCode,1),$URL);
        }
        $URL = str_replace("_param_","&",$URL);
    } else {
        $URL = $destination.'/cgi-bin/wxis.exe/applications/scielo-org/iah/?lang='.$lang.'&IsisScript=iah/iah.xis&base=article^dart.'.$instanceCode.'&nextAction=search&exprSearch='.$q.'&form=F&conectSearch=AND';
    }
}
header("Location:$URL");
ob_end_flush();
?>
