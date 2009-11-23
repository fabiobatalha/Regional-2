<?php
/*
 * This code is included by citedScielo.php and relatedScielo.php some variables
 * used in this code could being declared on these files.
 */

function upperCaseAuthors($xml){
    do {
        $aut = getContent('author', $xml);
        if (strlen($aut)>0){
            $names = explode(',',$aut);
            $upperCaseAuthorsXML = '<AUTHOR key="'.$aut.'" SEARCH="'.str_replace(',',',+',strtoupper(removeAccent(str_replace(' ','+',$aut)))).'"><NAME>'.$names[1].'</NAME><SURNAME>'.$names[0].'</SURNAME><UPP_NAME>'.strtoupper($names[1]).'</UPP_NAME><UPP_SURNAME>'.strtoupper($names[0]).'</UPP_SURNAME></AUTHOR>';
            $xml = str_replace('<author>'.$aut.'</author>', $upperCaseAuthorsXML, $xml);
        }
    } while (strlen($aut)>0);
    return $xml;
}

$serviceURL = str_replace("#PARAM_PID#",$pid,$serviceURL);
$serviceURL = str_replace("#PARAM_TEXT#",$text,$serviceURL);

$xmlh = file_get_contents($serviceURL);

for($chr = 0; $chr < 32 ;$chr++)
{
        $xmlh = str_replace(chr($chr),"",$xmlh);
}
$xmlh = str_replace(chr(146),"",$xmlh);
$xmlh = str_replace("<surname>","",$xmlh);
$xmlh = str_replace("</surname>",",",$xmlh);
$xmlh = str_replace("<name>","",$xmlh);
$xmlh = str_replace("</name>","",$xmlh);
$xmlh = upperCaseAuthors($xmlh);

$xml = '<?xml version="1.0" encoding="'.SYS_CHARSET.'" ?>'."\n";
$xml .= '<root>';
$xml .= '<CONTROLINFO>';
$xml .=         '<APP_NAME>'.SITE_NAME.'</APP_NAME>';
$xml .=         '<PAGE_NAME>'.$serviceName.'</PAGE_NAME>';
$xml .=         '<PAGE_PID>'.$pid.'</PAGE_PID>';
$xml .=         '<LANGUAGE>'.$lang.'</LANGUAGE>';
$xml .= '</CONTROLINFO>';
$xml .= '<vars>';
$xml .= '<lang>'.$lang.'</lang>';
$xml .= '<PATH>file://'.SITE_DOMAIN.'</PATH>';
$xml .= '</vars>';
$xml .= '<service_log>'.$flagLog.'</service_log>';
$xml .= str_replace('<?xml version="1.0" encoding="ISO-8859-1" ?>','',$xmlh);
$xml .= '</root>';

$xslFile = dirname(__FILE__) ."/../xsl/".$xslName.".xsl";

echo transformer($xml,$xslFile);
?>
