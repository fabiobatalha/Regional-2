<?php
$classPath=dirname(__FILE__).'/';
require_once($classPath . "/minixml.php");

class collexis
{
    var $webservice = "";
    var $wsParam = array();
    var $collectionServer = array();


    function collexis($collection, $thesaurus, $addThesaurus){
        global $collexis_def;

        $this->wsParam["collection"] = $collection;
        $this->wsParam["thesaurus"] = $thesaurus;
        $this->wsParam["additional_thesaurus"] = $addThesaurus;
        $this->wsParam["algorithm"] = $collexis_def["SEARCH_ALGORITHM"];
        $this->wsParam["related_concepts"] = $collexis_def["RELATED_CONCEPT"];
        $this->wsParam["count"] = $collexis_def["DOCUMENTS_PER_PAGE"];

        $this->setCollectionServer();
        $this->setWebService($collection);

        return;
    }

    function setCollectionServer(){
        global $collexis_def,$lang;

        if ($_SESSION['collectionServer'] != ''){
            $this->collectionServer = $_SESSION['collectionServer'];
        }else{
            $configXML = new MiniXMLDoc();
            $configXML->fromFile($collexis_def["DOCUMENT_ROOT"] . 'xml/' . $lang . '/config.xml');

            $configRoot = $configXML->toArray();

            foreach( $configRoot['config']['collection-list']['collection'] as $collection){
                $name = $collection['name'];
                $server = $collection['server'];

                $this->collectionServer[$name] = $server;
            }

            $_SESSION["collectionServer"] = $this->collectionServer;
        }
        return;
    }

    function setWebService($collection){
        global $collexis_def;
        
        if ( $this->collectionServer[$collection] != '' ){
            $server =  $this->collectionServer[$collection];
        }else{
            $server =  $collexis_def["COLLEXIS_SERVER"];
        }
        $this->webservice = "http://" . $server . "/webservices/collexis-modules.php?";

        return;
    }

    function setFrom($from){
        $this->wsParam["from"] = $from;
        return;
    }

    function search($expression){
        $this->wsParam["task"] = "search";
        $this->wsParam["expression"] = $expression;

        if ( isset($_POST['filter-list']) )
            $this->mountFilter();

        $wsResult = $this->documentPost($this->collexisUrl());
        return $wsResult;
    }

    function searchByFingerPrint($conceptList){
        $this->wsParam["task"] = "searchByFingerPrint";
        $this->wsParam["fingerprint"] = $this->mountFingerPrint($conceptList);
        $wsResult = $this->documentPost($this->collexisUrl());

        return $wsResult;
    }

    function related($id){

        $this->wsParam["task"] = "related";
        $this->wsParam["id"] = $id;

        $wsResult = $this->documentPost($this->collexisUrl());
        return $wsResult;
    }

    function fingerprint($id){
        $this->wsParam["task"] = "fingerprintById";
        $this->wsParam["id"] = $id;

        $wsResult = $this->documentPost($this->collexisUrl());
        return $wsResult;
    }

    function mountFingerPrint($conceptList){

        $fingerPrint = "<?xml version=\"1.0\" encoding=\"iso-8859-1\"?>";
        $conceptIdList = "";

        // percorre todas as variaveis do POST para criar um array com id e rank agrupados por tesauro
        foreach( $_POST as $key=>$value ){
            if ( ereg("^concept_",$key) == true){
                $conceptParts = split("_",$key);
                $conceptThesaurus = $conceptParts[1];
                $conceptId = $conceptParts[2];
                $conceptRank = $_POST['rank_' . $conceptId];
                $fingerprintList["$conceptThesaurus"]["$conceptId"] = $conceptRank;
                $conceptIdList.= $conceptId;
            }
        }

        //adiciona novo conceito selecionado
        if ($_REQUEST['add_concept_id'] != ''){
            $add_concept_id = $_REQUEST['add_concept_id'];
            $add_concept_thesaurus = $_REQUEST['add_concept_thesaurus'];

            // verifica se o conceito n�o existe na lista de conceitos da p�gina
            if ( strpos($conceptIdList, $add_concept_id) === false ){
                $fingerprintList["$add_concept_thesaurus"]["$add_concept_id"] = "1.1";
            }
        }

        //adiciona novo conceito manual
        if ($_REQUEST['add_concept_name'] != ''){

            $add_concept_name = $_REQUEST['add_concept_name'];
            $add_concept_thesaurus = $_REQUEST['add_concept_thesaurus'];

            //indexa termo para verificar se o mesmo consta do thesauro
            $wsRequestUrl = $this->webservice . "task=fingerprint&thesaurus=" . $this->wsParam["thesaurus"] . "&additional_thesaurus=freetext&output=4&expression=" . $add_concept_name;

            $wsResult = $this->documentPost($wsRequestUrl);

            $fpXML = new MiniXMLDoc($wsResult);
            $fpArray = $fpXML->toArray();

            foreach( $fpArray['fingerprintlist']['fingerprint'] as $fingerprint){
                $thesaurus = $fingerprint['_attributes']['thesaurus'];
                $concepts_count = $fingerprint['concepts']['_attributes']['count'];

                if ($concepts_count > 0){

                    if ($concepts_count == 1){
                        $concept_id = $fingerprint['concept']['_attributes']['id'];
                        $fingerprintList["$thesaurus"]["$concept_id"] = "1.1";
                    }else{
                        for ($i = 0; $i < $concepts_count; $i++){
                            $concept_id = $fingerprint['concept'][$i]['_attributes']['id'];
                            $fingerprintList["$thesaurus"]["$concept_id"] = "1.1";
                        }
                    }
                }
            }
            /*
            preg_match_all('/ id="([0-9]*)"/',$wsResult, $discovery_concepts);

            foreach ($discovery_concepts[1] as $new_concept){
                $fingerprintList["$add_concept_thesaurus"]["$new_concept"] = "1.1";
            }
            */
        }

        // cria fingerprintlist xml
        $fingerPrint.= "<fingerprintlist>";
        foreach( $fingerprintList as $thesaurus => $concepts){
            $fingerPrint.= "  <fingerprint thesaurus=\"" . $thesaurus . "\">";
            foreach ($concepts as $id => $rank){
                $required = "no";
                if ($rank == "1.1"){   //if concept is marked required (top)
                    $rank = "1";
                    $required = "yes";
                }
                $fingerPrint .= "<concept id=\"" . $id . "\" rank=\"" . $rank . "\" required=\"" . $required . "\"/>";
            }
            $fingerPrint.= "  </fingerprint>";
        }
        $fingerPrint.= "</fingerprintlist>";

        return $fingerPrint;
    }

    function mountFilter(){

        $filterXml = "";
        $filterList = split('#', $_POST['filter-list']);

        foreach ( $filterList as $filter){
            $field = substr( $filter, 0, strpos($filter,'|') );
            $condition = substr( $filter, strpos($filter,'|')+1 );
            $value = $_POST[$field];
            if ( is_array($value) ){
                $filterXml .= "<or>";
                foreach ($value as $combined){
                    $filterXml .= "<" . $condition . " field='" . $field . "' value='" . $combined . "'/>";
                }
                $filterXml .= "</or>";

            }else{
                if ($value != ''){
                    $filterXml .= "<" . $condition . " field='" . $field . "' value='" . $value . "'/>";
                }
            }
        }
        if ($filterXml != ''){
            $filterXml = "<and>" . $filterXml . "</and>";
            $this->wsParam["filter"] = $filterXml;
        }
        return;
    }

    function collexisUrl()    {
        $urlParam = "";
        reset($this->wsParam);
        while (list($key, $value) = each($this->wsParam))
        {
            if ($value != "")
            {
                $urlParam .= "&" . $key . "=" . $value;
            }
        }
        $wsRequestUrl = $this->webservice . substr($urlParam,1);

        //print_r ($this->wsParam);

        return $wsRequestUrl;
    }

    function documentPost( $url )
    {
        // Strip URL
        $url_parts = parse_url($url);
        $host = $url_parts["host"];
        $port = ($url_parts["port"] ? $url_parts["port"] : "80");
        $path = $url_parts["path"];
        $query = $url_parts["query"];
        $result = "";
        $timeout = 10;
        $contentLength = strlen($query);

        // Generate the request header
        $ReqHeader =
              "POST $path HTTP/1.0\r\n".
              "Host: $host\r\n".
              "User-Agent: PostIt\r\n".
              "Content-Type: application/x-www-form-urlencoded\r\n".
              "Content-Length: $contentLength\r\n\r\n".
              "$query\n";

        // Open the connection to the host
        $fp = fsockopen($host, $port, $errno, $errstr, $timeout);

        fputs( $fp, $ReqHeader );
        if ($fp) {
            while (!feof($fp)){
                $result .= fgets($fp, 4096);
            }
        }

        return strstr($result,"<");
    }

}

?>