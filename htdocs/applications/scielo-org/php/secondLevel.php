<?php
ob_start();
require_once(dirname(__FILE__)."/../../../php/include.php");//BVS SITE Includes
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes

if($def['LETTER_UNIT'] != null){
        $baseDir = $def['LETTER_UNIT'].$def['DATABASE_PATH'];
}else{
        $baseDir = $def['DATABASE_PATH'];
}

$instance   = $_REQUEST['instance'];
$collection = $_REQUEST['collection'];
$letter     = $_REQUEST['letter'];
$subject    = $_REQUEST['subject'];

?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <?require_once(dirname(__FILE__)."/../includes/htmlHead.php");?>
    <body>
        <div class="container">
            <div class="level2">
            <?
            $html = file_get_contents($baseDir."/html/" . $lang . "/bvs.html");
            echo utf8_encode($html);

            $xmlFile = dirname(__FILE__) . "/../webservices/xml/".$_GET["xml"].".xml";
            $xslFile = realpath(dirname(__FILE__) . "/..")."/xsl/".$_GET["xsl"].".xsl";
            if ($handle = fopen($xmlFile,'r')){
                $xmlh.=file_get_contents($xmlFile);
                $xml  = "<root>";
                $xml .= "<vars>";
                $xml .= "<DIR>".SITE_DOMAIN."</DIR>";
                $xml .= "<PATH>file://".SITE_PATH."</PATH>";
                $xml .= "<lang>".$lang."</lang>";
                $xml .= "<letter>".$letter."</letter>";
                $xml .= "<subject>".$subject."</subject>";
                $xml .= "<instance>".$instance."</instance>";
                $xml .= "<collection>".$collection."</collection>";
                $xml .= "</vars>";
                if (strpos(strtolower($xmlh), 'utf-8')){
                    $xmlh = $xmlh;
                    $xmlh = str_replace('<?xml version="1.0" encoding="utf-8"?>','',$xmlh);
                    $xmlh = str_replace('<?xml version="1.0" encoding="UTF-8"?>','',$xmlh);
                }

                $xmlh = str_replace('&amp;REPLACE_LNG=xx','&amp;lng='.$lang,$xmlh);


                $xml .= str_replace('<?xml version="1.0" encoding="ISO-8859-1"?>','',$xmlh);
                $xml .= "</root>";
                echo transformer($xml,$xslFile);
            }else{
                echo "Could not open XML file ".$xmlFile;
            }
            ?>
            <!--End of middle content for second level pages -->
            </div>
        </div>
    </body>
    <?if ( $def['GOOGLE_ANALYTICS_ID'] != ''){?>
        <!-- Google analytics -->
        <script src="http://www.google-analytics.com/urchin.js" type="text/javascript"></script>
        <script type="text/javascript">
            _uacct = "<?=$def['GOOGLE_ANALYTICS_ID']?>";
            urchinTracker();
        </script>
    <?}?>
</html>
<?ob_end_flush?>