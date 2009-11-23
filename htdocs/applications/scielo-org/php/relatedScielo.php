<?php
require_once(dirname(__FILE__)."/../../../php/include.php");//BVS SITE Includes
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes

$tlang = isset($_REQUEST['tlang'])?($_REQUEST['tlang']):"en";
$lang = isset($_REQUEST['lang'])?($_REQUEST['lang']):"en";
$pid = isset($_REQUEST['pid'])?($_REQUEST['pid']):"";
$text = isset($_REQUEST['text'])?($_REQUEST['text']):"";

$service = "related";
$xslName = "related";
$serviceURL = TRIGRAMAS_RELATED_PID;
$xpath = "//related";
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <?require_once(dirname(__FILE__)."/../includes/htmlHead.php");?>
    <body>
        <div class="container">
            <div class="level2">
                <div class="bar">
                </div>
                <div class="top">
                    <div id="parent">
                        <img src="../image/public/skins/classic/pt/banner.jpg" alt="SciELO - Scientific Electronic Library Online"/>
                    </div>
                    <div id="identification">
                        <h1>
                            <span>
                                SciELO - Scientific Electronic Library Online
                            </span>
                        </h1>
                    </div>
                </div>
                <div class="middle">
                    <div id="collection">
                        <h3>
                            <span><?= SIMILARS_IN." SciELO"?></span>
                        </h3>
                        <div class="content">
                            <TABLE border="0" cellpadding="0" cellspacing="2" width="760" align="center">
                                <TR>
                                    <TD colspan="2">
                                    <?php
                                        include_once("common.php");
                                    ?>
                                    </TD>
                                </TR>
                            </TABLE>
                        </div>
                    </div>
                </div>
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