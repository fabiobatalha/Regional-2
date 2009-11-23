<?php
require_once (dirname(__FILE__)."/../classes/Tools.php");

function transformer($xmlC,$xslF){

   //converting input string to UTF-8;
   $charTools = new CharTools();
   $xmlinUTF8 = $charTools->eqStrCharset($xmlC);

   $xml = new DomDocument();
   $xml->loadXML($xmlinUTF8);

   // indica o arquivo XSLT
   $xsl = new DomDocument();
   $xsl->load($xslF);

   // cria o processador XSLT, carrega stylesheet e transforma o XML
   $proc = new XSLTProcessor();
   $proc->importStyleSheet($xsl);

   return $proc->transformToXML($xml);
}

function getContent($tag, $s){
    $p = strpos($s, "<$tag>");
    $rest = substr($s, $p+ strlen("<$tag>"));
    if ($p){
        $x = substr($s,$p+ strlen("<$tag>"));
        $p = strpos($x, "</$tag>");
        if ($p) {
            $r = substr($x,0,$p);

        }
    }
    return $r;
}

function removeAccent($s){
    $a = array("�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�","�");
    $b = array("a","a","a","a","a","e","e","e","e","o","o","o","o","o","i","i","i","i","u","u","u","u","n","c");

    return str_replace($a, $b, $s);
}
?>