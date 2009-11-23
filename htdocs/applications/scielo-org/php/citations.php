<?php
require_once(dirname(__FILE__)."/../../../php/include.php");//BVS SITE Includes
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes

if($def['LETTER_UNIT'] != null){
        $baseDir = $def['LETTER_UNIT'].$def['DATABASE_PATH'];
}else{
        $baseDir = $def['DATABASE_PATH'];
}
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
            ?>
                <div class="middle">
                    <div id="breadCrumb">
                        <a href="/index.php?lang=<?=$lang?>"><?=HOME?></a> &gt; <?=NUMBERS?>
                    </div>
                    <div class="content">
                        <h3><span><?=CITATION?></span></h3>
                         <ul>
                            <? echo '<!-- '.str_replace('PARM_LANG', $lang, STATBIBLIO_GET_INSTANCES ).' -->'?>
                            <?=utf8_encode(file_get_contents(str_replace('PARM_LANG', $lang, STATBIBLIO_GET_INSTANCES )))?>
                         </ul>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>