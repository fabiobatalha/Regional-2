<?php
/**
 * Common Tools
 *
 * @package     Plataforma de Serviços da BVS
 * @author      Fabio Batalha C. Santos (fabio.santos@bireme.org)
 * @author      Gustavo Fonseca (gustavo.fonseca@bireme.org)
 * @copyright   BIREME
 *
 */

/*
 * Edit this file in UTF-8 - Test String "áéíóú"
 */

/**
 * charset convertion utilities
 */
class CharTools {

    /**
     * Equalize the input string charset
     *
     * @param string $string
     * @return string
     */
    public static function eqStrCharset($string){
        /* if the string charset is different from the sys charset */
        if(!mb_check_encoding($string,SYS_CHARSET)){
            /* convert to the defined sys internal charset */
            return mb_convert_encoding($string,SYS_CHARSET,mb_detect_encoding($string,ACCEPTED_CHARSETS));
        }else{
            return $string;
        }
    }

    /**
     * Equalize the input string array charset
     *
     * @param string $arrString String array
     * @return string String array
     */
    public static function eqStrCharsetFromArray($arrString){
        $retValue = false;
        if(is_array($arrString)){
            $retValue = array();
            foreach($arrString as $key => $value){
                $retValue[$key] = self::eqStrCharset($value);
            }
        }
        return $retValue;
    }
}
?>