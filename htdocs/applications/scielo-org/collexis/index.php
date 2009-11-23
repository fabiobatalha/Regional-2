<?PHP
require_once(dirname(__FILE__)."/../../../php/include.php");//BVS SITE Includes
require_once(dirname(__FILE__)."/../includes/include.php");//SciELO ORG Includes
require_once(dirname(__FILE__)."/php/classes/collexis.php");
require_once(dirname(__FILE__)."/php/classes/page.php");

$collexis_def = parse_ini_file("collexis.def");

if($def['LETTER_UNIT'] != null){
        $baseDir = $def['LETTER_UNIT'].$def['DATABASE_PATH'];
}else{
        $baseDir = $def['DATABASE_PATH'];
}

if ( !isset($_REQUEST["lang"]) ) {
    $lang = $collexis_def["DEFAULT_LANGUAGE"];
} else {
    $lang = $_REQUEST["lang"];
}

$page = new page($collexis_def);

$task = ($_REQUEST['task'] ? $_REQUEST['task'] : "init");
$from = $_REQUEST['from'];
$expression = htmlspecialchars($_REQUEST['expression']);
$lang = ($_REQUEST['lang'] ? $_REQUEST['lang'] : $collexis_def['DEFAULT_LANGUAGE']);

if ($task != 'init'){
    $collexis = new collexis($_REQUEST['collection'], $_REQUEST['thesaurus'],$_REQUEST['additional_thesaurus']);
}

if ($from != "" and $task != 'init')
    $collexis->setFrom($from);

switch ($task){
    case 'init' :
        $page->setXsl(dirname(__FILE__)."/xsl/main.xsl");
        break;
    case 'search' :
        if ($expression != ""){
            $page->setXsl(dirname(__FILE__)."/xsl/result.xsl");
            $collexisXml= $collexis->search($expression);
            $page->setXml($collexisXml);
        }else{
            $page->setXsl(dirname(__FILE__)."/xsl/main.xsl");
        }
        break;
    case 'related':
        $page->setXsl(dirname(__FILE__)."/xsl/result.xsl");
        $collexisXml= $collexis->related($_REQUEST['related_id']);
        $page->setXml($collexisXml);
        break;
    case 'show_fingerprint':
        $page->setXsl(dirname(__FILE__)."/xsl/fingerprint.xsl");
        $collexisXml= $collexis->fingerprint($_REQUEST['sid']);
        $page->setXml($collexisXml);
        break;

    case 'search_by_fingerprint' :
        $page->setXsl(dirname(__FILE__)."/xsl/result.xsl");
        $collexisXml= $collexis->searchByFingerPrint($_REQUEST['concept_list']);
        $page->setXml($collexisXml);
        break;

}

if ($task == 'show_fingerprint'){
    $page->build();
    die();
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" 
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title>
            <?=$title[$item]?>
        </title>
        <link rel="stylesheet" href="css/screen.css" type="text/css"/>
        <title>
            <?= $scielodef["site"]["name"]?>
        </title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta http-equiv="Expires" content="-1"/>
        <meta http-equiv="pragma" content="no-cache"/>
        <meta name="author" content="BIREME (http://www.bireme.br/)"/>
        <meta name="keywords" content="information, health, bibliography, library, knowledge, health information, virtual library"/>
        <meta name="description" content="Virtual Health Library - Information and Knowledge"/>
        <meta name="robots" content="all" />
        <meta name="MSSmartTagsPreventParsing" content="true" />
        <link rel="shortcut icon" href="<?=$def['DIRECTORY']?>favicon.ico"/>
        <link rel="stylesheet" href="/applications/scielo-org/css/public/print.css" type="text/css" media="print"/>
        <link rel="stylesheet" href="/applications/scielo-org/css/public/style-<?=$checked['lang']?>.css" type="text/css" media="screen"/>
        <script language="javascript" src="js/functions.js"></script>
        <script language="javascript">var PATH_DATA = '<?=$collexis_def["$PATH_DATA"]?>';</script>
    </head>
    <body>
        <div class="container">
            <div class="level2">
                <?
                $html = file_get_contents($baseDir."/html/" . $lang . "/bvs.html");
                    echo utf8_encode($html);
                ?>
                <div class="middle">
                  <div id="breadCrumb">
                    <a href="/index.php?lang=<?=$_RESQUEST['lang']?>"><?=HOME?> </a>&gt; <?=SIMILARITY?>
                    </div>
                    <div class="content">
                    <?
                    $arr = split(",",ARR);
                    $lista = array();
                    foreach($arr as $item){
                        $v = split("\|",$item);
                        $lista[$v[0]] = $v[1];
                    }
                    $a = strtoupper($_REQUEST['collection']);
                    $instance = $lista[$a];
                    ?>
                        <h3><span><?=SEARCHING_IN?>: <?=$instance?></span></h3>
                        <? $page->build(); ?>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
