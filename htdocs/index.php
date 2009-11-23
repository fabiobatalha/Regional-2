<?php
    $redirect = "./php/index.php";
    $expected = array(
        'lang'      => '/^(en|es|pt)$/',
        'component' => '/^[1-9][0-9]$/',
        'item'      => '/^[1-9][0-9]$/',
        'portal'    => '/^[a-zA-Z0-9_]+$/',
    );

    $op = '?';
    foreach ( $expected as $param => $test ){
        if( isset($_REQUEST[$param]) && preg_match($test, $_REQUEST[$param]) ){
            $redirect .= $op . $param . '=' . $_REQUEST[$param];
            $op = '&';
        }
    }

    header("Location: " . $redirect);
?>
