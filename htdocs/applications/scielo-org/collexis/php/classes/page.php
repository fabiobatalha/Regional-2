<?PHP

class page
{
    var $xsl = "";
    var $xml = "";

    function page(){

    }

    function build()
    {
        if ($this->xml == ''){
            $this->setXml();
        }
        return $this->showPage();
    }


    function setXml($collexisXml = '')
    {
        global $collexis_def,$lang;

        $configXmlFile = $collexis_def["DOCUMENT_ROOT"] . "xml/" . $lang . "/config.xml";
        $configXml = $this->docReader($configXmlFile, true);
        if ($collexisXml != ''){
            $collexisXml = $this->removeXmlHeader($collexisXml);
        }

        $this->xml = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>";
        $this->xml.= "\n<MAIN>";
        $this->xml.= $this->xmlNode($_REQUEST, "vars");
        $this->xml.= $this->xmlNode($collexis_def, "define");
        $this->xml.= $configXml;
        $this->xml.= $collexisXml;
        $this->xml.= "\n</MAIN>";
        return;
    }

    function setXsl($xsl)
    {
        $this->xsl = $xsl;
    }

    function showPage()
    {
        global $collexis_def;
        $result = "";
       $xml = new DomDocument();
       $xml->loadXML($this->xml);

       // indica o arquivo XSLT
       $xsl = new DomDocument();
       $xsl->load($this->xsl);

       // cria o processador XSLT, carrega stylesheet e transforma o XML
       $proc = new XSLTProcessor();
       $proc->importStyleSheet($xsl);

       print $proc->transformToXML($xml);
    }

    function getXml()
    {
        return $this->xml;
    }

    function xmlNode($arrayElement, $root)
    {
        $xmlString = "<$root>\n";
        if ( is_array($arrayElement) ){

            reset($arrayElement);
            $myKey =  key($arrayElement);
            while ($myKey)
            {
                if (count($arrayElement[$myKey]) <= 1 and !(is_array($arrayElement[$myKey])) )
                {
                    $arrayValue = htmlspecialchars($arrayElement[$myKey]);
                    $xmlString .= "<$myKey>" . stripslashes($arrayValue) . "</$myKey>\n";
                }
                else
                {
                    $xmlString .= "<" . $myKey . "_list>";
                    foreach ( $arrayElement[$myKey] as $arrayName => $arrayValue){

                        $xmlString .= "<$myKey>" . "<name>" . $arrayName . "</name>";
                        if ( is_array($arrayValue) )
                        {
                            $xmlString .= "<group_list>";
                            foreach ( $arrayValue as $arrayDeptName => $arrayDeptValue ){
                                $xmlString .= "<group><name>" . $arrayDeptName. "</name>" . "<value>" . $arrayDeptValue . "</value></group>";
                            }
                            $xmlString .= "</group_list>";
                        }
                        else
                        {
                            $xmlString .= "<value>" . $arrayValue . "</value>";
                        }
                        $xmlString .= "</$myKey>\n";
                    }
                    $xmlString .= "</" . $myKey . "_list>";
                }
                next ($arrayElement);
                $myKey = key($arrayElement);
            }
        }

        $xmlString .= "</$root>";
        return $xmlString;
    }

    function docReader($file, $removeXmlHeader = false)
    {
        $str = "";
        $fp = fopen($file,"r");
        if ($fp)
        {
            while (!feof ($fp)) {
                $buffer= fgets($fp, 8096);
                $str.= $buffer;
            }
            fclose ($fp);
        }

        if ( $removeXmlHeader == true )
        {
            $str = $this->removeXmlHeader($str);
        }
        
        return $str;
    }

    function removeXmlHeader($xml)
    {
       /* remove xml processing instruction */
       if ( strncasecmp($xml, "<?xml", 5) == 0 )
       {
           $pos = strpos($xml, "?>");
           if ( $pos > 0 ){
              $xml = substr_replace($xml,"",0,$pos + 2);
           }
       }
       return $xml;

    }

}

?>
