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
                        <a href="/index.php?lang=pt"><?=HOME?></a> &gt; <?=NUMBERS?>
                    </div>
                    <div class="content">
                        <h3><span><?=USAGE?></span></h3>
                            <ul>
                                <li><a href="http://www.scielo.br/scielo.php?script=sci_stat&lng=<?php echo $lang ?>&nrm=iso" target="_blank">Brasil</a></li>
                                <li><a href="http://www.scielo.cl/scielo.php?script=sci_stat&lng=<?php echo $lang ?>&nrm=iso" target="_blank">Chile</a></li>
                                <li><a href="http://www.scielosp.org/scielo.php?script=sci_stat&lng=<?php echo $lang ?>&nrm=iso" target="_blank">Saúde Pública</a></li>
                            </ul>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

<?
ob_end_flush();
?>
