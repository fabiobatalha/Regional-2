<?PHP
$place = split("\|",$_POST["where"]);
$instanceUrl = $place[0];
$instanceCode = $place[1];
$collexisCollectionName = $place[2];

header("Location: index.php?task=search&collection=".$collexisCollectionName."&thesaurus=decs2005_" . $_REQUEST['lang'] . "&additional_thesaurus=freetext&expression=" . $_REQUEST['expression'] . "&lang=" . $_REQUEST['lang']);

?>
