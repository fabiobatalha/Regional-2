<?php
$where = split("\|",$_REQUEST['where']);
header("Location: http://search.scielo.org/?q=".$_REQUEST['expression']."&where=".strtoupper($where[1]));
?>
