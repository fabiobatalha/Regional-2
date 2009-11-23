<?php
/**
 * Define global variables and system behavior
 *
 * This file script set system behavior loading the configuration
 * file bvs-site-conf.php and $_REQUEST variables
 *
 * PHP version 5
 */

/*
 * Edit this file in ISO-8859-1 - Test String �����
 */
$DirNameLocal=dirname(__FILE__).'/';
//error_reporting( 0 );
//ini_set('display_errors', "On");

// define constants
define("VERSION","5.2.1");
define("USE_SERVER_PATH", false);

if (USE_SERVER_PATH == true){
    if( isset($_SERVER["PATH_TRANSLATED"]) ){
        $pathTranslated = dirname($_SERVER["PATH_TRANSLATED"]);
    } else {
        $pathTranslated = dirname($_SERVER["SCRIPT_FILENAME"]);
    }
    $sitePath = dirname($pathTranslated);
}else{
    $sitePath = realpath($DirNameLocal . "..");
}
$def = parse_ini_file($sitePath ."/bvs-site-conf.php");

$lang = "";

if ( !isset($_REQUEST["lang"]) || $_REQUEST["lang"] == "" ) {
    if (!isset($_COOKIE["clientLanguage"])) {
        $lang = $def["DEFAULT_LANGUAGE"];
    } else {
        $lang = $_COOKIE["clientLanguage"];
    }
} else {
    $lang = $_REQUEST["lang"];
    setCookie("clientLanguage",$lang,time()+60*60*24*30,"/");
}

// URL parameters security filter
$checked  = array();

if ( isset($_GET["component"]) && !ereg("^[0-9]+$", $_GET["component"]) )
    die("404 - File Not Found");
else
    $checked['component'] = $_GET["component"];

if ( isset($_GET["item"]) && !ereg("^[0-9]+$", $_GET["item"]) )
    die("404 - File Not Found");
else
    $checked['item'] = $_GET["item"];

if ( isset($_GET["id"]) && !ereg("^[0-9]+$", $_GET["id"]) )
    die("404 - File Not Found");
else
    $checked['id'] = $_GET["id"];

if ( !ereg("^(pt)|(es)|(en)$",$lang) )
    die("invalid parameter lang" . $lang);
else
    $checked['lang'] = $lang;


$def['DEFAULT_DATA_PATH'] = $def['DATABASE_PATH'];
if ( isset($_REQUEST['portal']) && preg_match('/^[a-zA-Z0-9_]+$/', $_REQUEST['portal'])){
    $portal_path = preg_replace(
        '/[a-zA-Z0-9_]+\/$/',
        '',
        $def['DATABASE_PATH']
    );
    $portal_path .= $_REQUEST['portal'];

    if( file_exists($portal_path)){
        $checked['portal'] = $_REQUEST['portal'];
        $def['DATABASE_PATH'] = $portal_path . '/';
    }
    unset( $portal_path );
}

foreach ($def as $key => $value){
    define($key, $value);
}

$localPath['html']= $def['DATABASE_PATH'] . "html/" . $checked['lang'] . "/";
$localPath['xml'] = $def['DATABASE_PATH'] . "xml/" . $checked['lang'] . "/";
$localPath['ini'] = $def['DATABASE_PATH'] . "ini/" . $checked['lang'] . "/";

//IAH - METAIAH PATH  Para SciELO ORG
$IAHService = 'applications/scielo-org/iah';
unset($database);
?>