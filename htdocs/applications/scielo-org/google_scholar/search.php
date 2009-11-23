<?
require_once(dirname(__FILE__)."/../config.php");//SciELO ORG Configure

$q = urlencode(utf8_encode($_REQUEST['expression']));
$index = $_SERVER["HTTP_REFERER"];

$place = split("\|",$_POST["where"]);
$instanceCode = $place[1];
$instanceUrl = $place[0];
$searchUrl = str_replace("#search_expression#",$q,GOOGLESCHOLAR_SEARCH);
$searchUrl = str_replace("#collection#",$instanceUrl,$searchUrl);

header("Location: ".$searchUrl);
exit;

?>