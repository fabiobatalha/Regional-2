<?php
require('auth_check.php');
require('../php/include.php');
require('../php/common.php');

$location  = DIRECTORY
           . "admin/admFrames.php"
           . "?lang=" . $checked['lang']
           . (isset($checked['portal'])?'&portal='.$checked['portal']:'');

header("Location: " . $location );

?>

