<?php
require_once(dirname(__FILE__)."/../../../php/include.php");//BVS SITE Includes
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes
require_once(dirname(__FILE__)."/../classes/DBClass.php");

if($def['LETTER_UNIT'] != null){
        $baseDir = $def['LETTER_UNIT'].$def['DATABASE_PATH'];
}else{
        $baseDir = $def['DATABASE_PATH'];
}

if (trim($_REQUEST['expression']) != ""){
    $expression = "title LIKE '%".str_replace(" ","%' and title LIKE '%",trim($_REQUEST['expression']))."%'";
}else{
    $expression = "title LIKE '%%'";
}
$query = "SELECT * FROM journals WHERE ".$expression." ".$condition." ORDER BY title,collection";
$db = new DBClass();
$result = $db->databaseQuery($query);
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
                        <a href="/index.php?lang=<?=$lang?>"><?=HOME?></a>&gt; <?=SEARCH_JOURNALS?>
                </div>
                <div class="content">
                        <?$expression=($_REQUEST['expression']=="")? ALL:$_REQUEST['expression'];?>
                        <h3><span><?=SEARCH_JOURNALS?> - <?=$expression?> - <?=FIND_RESULTS?> <?=count($result)?></span></h3>
                        <ul>
            <?
                        foreach($result as $reg){?>
                            <li>

                            <a target="_blank" href="<?=$reg['collectionUrl']?>/scielo.php?script=sci_serial&pid=<?=$reg['issn']?>&nrm=iso&lng=<?=$lang?>"><?=$reg['title']?></a>
                            <?if (!$condition) {?>
                                <span class="collectionName"> [<?=$reg['collection']?>]</span>
                            <?}?>
                            </li>
                        <?}?>
                       </ul>
                </div>
            <!--End of Middle-->
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
