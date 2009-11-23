<?php

$xmlRootPath = dirname(__FILE__).'/';

require($xmlRootPath . '../admin/auth_check.php');
require($xmlRootPath . '../php/include.php');
require($xmlRootPath . "./xmlRoot_functions.php");

$xml = ( $xml != "" ? $xml : $_REQUEST['xml'] );
$xsl = ( $xsl != "" ? $xsl : $_REQUEST['xsl'] );
$lang = ( $lang != "" ? $lang : $_REQUEST['lang'] );
$page = ( $page != "" ? $page : $_REQUEST['page'] );

$xslSave = $_REQUEST['xslSave'];
$xmlSave = $_REQUEST['xmlSave'];

check_parameters();

$check_login = false;
if (eregi("(adm.xml)|(users.xml)",$checked['xml'])  ){
    $checked['xml'] = file_get_contents(DEFAULT_DATA_PATH . $checked['xml']);
    $check_login = true;
} else if ( eregi("adm",$checked['xsl']) || isset($xmlSave) ){
    $check_login = true;
}

if ( $check_login ){
    auth_check_login();
}

$xmlContent = BVSDocXml("root",$checked['xml']);

if ( isset($_REQUEST['debug']) ){
    debug($_REQUEST['debug']);
}

$xsl_params = array();
if ( isset($checked['portal']) ){
    $xsl_params['portal'] = $checked['portal'];
}

if ( isset($xslSave) )
{
    $xslSave = "../" . $checked['xslSave'];
    
    $sucessWriteXml = xmlWrite($xmlContent,$xslSave,$checked['xmlSave'],$xsl_params);
    if ( $sucessWriteXml != '' && $checked['page'] != 'users' ){
        // generate html
        htmlWrite($sucessWriteXml,$xsl_params);

        // generate ini
        iniWrite($sucessWriteXml,$xsl_params);

        if ($checked['page'] == 'collection' || $checked['page'] == 'topic'){
            // generate metaiah define xml
            defineMetaIAHWrite();
        }
    }

    if ( isset($xmlT) ){
        if ( $xmlT == "saved" ){
            $xmlContent = BVSDocXml("root",$checked['xmlSave']);
        }
    }
}

$xslTransform = SITE_PATH . $checked['xsl'];

if ( $debug == "XSL" ) { die($xslContent); }

if ( isset($checked['xsl']) ){
    print( processTransformation($xmlContent,$xslTransform,$xsl_params) );
} else {
    print($xmlContent);
}

?>

