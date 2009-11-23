<?php
    require("../php/include.php");
    session_start();


    //check system directories
    function checkSystem(){
        global $messagem, $def;

        $language = array("pt","es","en");
        $diretory = array("xml","html", "ini");

        if ( !is_dir( $def['SITE_PATH'] ) ){
            $cause = $message["invalid_dir"] . $def['SITE_PATH'];
            printError($cause, $message["check_def"]);

            return false;
        }

        foreach ($language as $lang){

            foreach ($diretory as $dir){
                $dir_path = $def['DATABASE_PATH'] . $dir . "/" . $lang . "/";
                if ( !is_writeable( $dir_path ) ) {
                    $cause = $message["invalid_perm"] . $dir_path;
                    printError($cause, $message["check_perm"]);

                    return false;
                }
            }
        }

        return true;
    }

    function printError($cause, $solution){
        global $message;

        print "<div style='font-weight: bold'>";
        print "<font color='#cc0000'>" . $message["install_error"] . "</font><br/>";
        print $cause . "<br/>";
        print $solution;
        print "</div>";
    }

    $messageArray = array (
        "es" =>
            array (
                "adm" => "Administraci�n de la BVS",
                "user" => "usuario",
                "password" => "contrase�a",
                "enter" => "entre",
                "lang1" => "<a href=\"index.php?lang=pt\">portugu�s</a>",
                "lang2" => "<a href=\"index.php?lang=en\">english</a>",
                "timeout" => "Tiempo de conexi�n encerrado, por favor efect�e nuevamente el login.",
                "install_error"=> "Error de instalaci�n",
                "invalid_dir" => "Causa: directorio inv�lido: ",
                "invalid_perm"=> "Causa: no es posible grabar en el directorio: ",
                "invalid_user_file" => "Causa:  no fue posible localizar el archivo de usuarios del sistema. ",
                "check_def"   => "Posible soluci�n: verificar las rutas en el archivo de configuraci�n bvs-site-conf.php",
                "check_perm"  => "Posible soluci�n: ajustar los permisos para este directorio",
                "popup_blocker"=>"Atenci�n: Antes de seguir es necesario configurar su navegador para permitir la apertura de ventanas popup en este sitio.",
            ),
        "pt" =>
            array (
                "adm" => "Administra��o da BVS",
                "user" => "usu�rio",
                "password" => "senha",
                "enter" => "entre",
                "lang1" => "<a href=\"index.php?lang=es\">espa�ol</a>",
                "lang2" => "<a href=\"index.php?lang=en\">english</a>",
                "timeout" => "Tempo de conex�o encerrado, por favor efetue novamente o login.",
                "install_error"=> "Erro de instala��o",
                "invalid_dir" => "Causa: diret�rio inv�lido: ",
                "invalid_perm"=> "Causa: n�o � possivel gravar no diret�rio: ",
                "invalid_user_file" => "Causa: n�o foi possivel localizar o arquivo de usu�rios do sistema.  ",
                "check_def"   => "Possivel solu��o: verificar os caminhos indicados no arquivo de configura��o bvs-site-conf.php",
                "check_perm"  => "Possivel solu��o: ajustar as permiss�es para este diret�rio",
                "popup_blocker"=> "Aten��o: Antes de prosseguir � necess�rio configurar seu navegador para permitir a abertura de janelas popup neste site.",
            ),
        "en" =>
            array (
                "adm" => "BVS Administration",
                "user" => "user",
                "password" => "password",
                "enter" => "enter",
                "lang1" => "<a href=\"index.php?lang=es\">espa�ol</a>",
                "lang2" => "<a href=\"index.php?lang=pt\">portugu�s</a>",
                "timeout" => "Connection timeout, please login again.",
                "install_error"=> "Install error",
                "invalid_dir" => "Cause: invalid directory: ",
                "invalid_perm"=> "Cause: no write permission in the diretory: ",
                "invalid_user_file" => "Cause:  unable to locate the users system file. ",
                "check_def"   => "Posible solution: verify system path's on bvs-site-conf.php file",
                "check_perm"  => "Posible solution:  adjust directory permission",
                "popup_blocker" => "Attention: Before continue is necessary to configure your browser to permit opening popup window in this site."
            ),
    );
    $message = $messageArray[$lang];

    if ( checkSystem() == false ){
        die();
    }

?>


<html>
<head>
    <title><? print($message["adm"]); ?></title>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1"/>
    <script language="JavaScript">
        var formPage = null;
        var wOpen = null;
        var isPopupBlocker = null;

        var oWin = window.open("","testpopupblocker","width=100,height=50,top=5000,left=5000");
        if (oWin==null || typeof(oWin)=="undefined") {
            isPopupBlocker = true;
        } else {
            oWin.close();
            isPopupBlocker = false;
        }

        function go ( )
        {
            formPage = document.formPage;
            wOpen = window.open( "", "bvs_admin", "top=10,left=10,height=530,width=785,menubar=no,location=no,resizable=yes,scrollbars=yes,status=yes" );

            setTimeout("formPage.submit(); wOpen.focus();",200);
        }


        function checkSubmit(){
            if (document.formPage.auth_usr.value != '' && document.formPage.auth_pwd.value != ''){
                if ( isPopupBlocker ){
                    alert("<?=$message['popup_blocker']?>");
                    return false;
                }
            }
            return true;
        }

    </script>
    <link rel="stylesheet" href="<?=DIRECTORY?>css/admin/adm.css" type="text/css"/>
</head>


<body onLoad="document.formPage.auth_usr.focus();">
    <form action="auth_user.php"  name="formPage" onSubmit="return( checkSubmit() );" method="POST">
    <?if(isset($checked['portal'])){?>
    <input type="hidden" name="portal" value="<?=$checked['portal']?>"/>
    <?}?>
    <input type="hidden" name="lang" value="<? print($lang); ?>">
    <table width="600">
        <tr>
            <td align="left">
                <? print($message["adm"]); ?>
            </td>
            <td align="right">
                <? print($message["lang1"]); ?> &#160;
                <? print($message["lang2"]); ?>
            </td>
        </tr>
    </table>
    <hr noshade=""/>
    <ul type="disc">
        <li>
            <? print($message["user"]); ?><br/>
            <input type="text" name="auth_usr" maxlength="30"/>
        </li>
        <li>
            <? print($message["password"]); ?><br/>
            <input type="password" name="auth_pwd" maxlength="30"/><br/>
            <br/>
            <input type="submit" name="auth_submit" value="<? print($message["enter"]); ?>" />
        </li>
    </ul>
    <? if ($_REQUEST['timeout'] == 'session') { ?>
        <div>
            <?=$message['timeout']?>
        </div>
    <? } ?>
    <script language="javascript">
        if (isPopupBlocker) {
            document.write("<img src='../image/common/popup.gif' align='middle'> <font color='#cc0000'><?=$message['popup_blocker']?></font>");
        }
    </script>


    </form>
    <div class="copyright" style="margin-top: 380px;">
        BVS Site <?= VERSION ?> &copy; <a href="http://www.bireme.br/" target="_blank">BIREME/OPS/OMS</a>
    </div>
</body>
</html>

