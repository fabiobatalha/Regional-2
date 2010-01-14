<?php
if(!isset($_REQUEST['service'])){
	die("missing parameter <i>service</i>");
}

$service = $_REQUEST['service'];

$clientesoap = new SoapClient('http://'.$_SERVER["HTTP_HOST"].'/applications/scielo-org/webservices/indexBVS.wsdl', array('encoding' => 'ISO-8859-1'));

switch($service){
	case "search":
		if(!isset($_REQUEST['expression'])){
			die("missing parameter <i>expression</i>");
		}
		if(!isset($_REQUEST['from'])){
			die("missing parameter <i>from</i>");
		}
		if(!isset($_REQUEST['count'])){
			die("missing parameter <i>count</i>");
		}
		if(!isset($_REQUEST['collection'])){
			die("missing parameter <i>collection</i>");
		}
		
		try{
			$resultado = $clientesoap->search($_REQUEST['expression'], 
        $_REQUEST['from'], $_REQUEST['count'], $_REQUEST['collection']);	
		}catch(Exception $e){
			die('Error: ' . $e->getMessage());
		}
		
		break;
	case "searchHG":
		if(!isset($_REQUEST['expression'])){
			die("missing parameter <i>expression</i>");
		}
		if(!isset($_REQUEST['from'])){
			die("missing parameter <i>from</i>");
		}
		if(!isset($_REQUEST['count'])){
			die("missing parameter <i>count</i>");
		}
		if(!isset($_REQUEST['collection'])){
			die("missing parameter <i>collection</i>");
		}
    
		try{
      $resultado = $clientesoap->searchHG($_REQUEST['expression'], 
        $_REQUEST['from'], $_REQUEST['count'], $_REQUEST['collection']);
    }catch(Exception $e){
      die('Error: ' . $e->getMessage());
    }
    
		break;
	case "advancedSearch":
		if(!isset($_REQUEST['index'])){
			die("missing parameter <i>index</i>");
		}
		if(!isset($_REQUEST['expression'])){
			die("missing parameter <i>expression</i>");
		}
		if(!isset($_REQUEST['from'])){
			die("missing parameter <i>from</i>");
		}
		if(!isset($_REQUEST['count'])){
			die("missing parameter <i>count</i>");
		}
		if(!isset($_REQUEST['collection'])){
			die("missing parameter <i>collection</i>");
		}
    
		try{
      $resultado = $clientesoap->advancedSearch($_REQUEST['index'], 
        $_REQUEST['expression'], $_REQUEST['from'], $_REQUEST['count'], 
        $_REQUEST['collection']);
    }catch(Exception $e){
      die('Error: ' . $e->getMessage());
    }
    
		break;
	case "advancedSearchHG":
		if(!isset($_REQUEST['index'])){
			die("missing parameter <i>index</i>");
		}
		if(!isset($_REQUEST['expression'])){
			die("missing parameter <i>expression</i>");
		}
		if(!isset($_REQUEST['from'])){
			die("missing parameter <i>from</i>");
		}
		if(!isset($_REQUEST['count'])){
			die("missing parameter <i>count</i>");
		}
		if(!isset($_REQUEST['collection'])){
			die("missing parameter <i>collection</i>");
		}
		
    try{
      $resultado = $clientesoap->advancedSearchHG($_REQUEST['index'], 
        $_REQUEST['expression'], $_REQUEST['from'], $_REQUEST['count'], 
        $_REQUEST['collection']);
    }catch(Exception $e){
      die('Error: ' . $e->getMessage());
    }
    
		break;
	case "listRecords":
		if(!isset($_REQUEST['count'])){
			die("missing parameter <i>count</i>");
		}
		if(!isset($_REQUEST['collection'])){
			die("missing parameter <i>collection</i>");
		}
		
    try{
      $resultado = $clientesoap->listRecords($_REQUEST['count'], 
        $_REQUEST['collection']); // Alterar o nome do serviço. 
    }catch(Exception $e){
      die('Error: ' . $e->getMessage());
    }
    
		break;
	case "lastRecords":		
		if(!isset($_REQUEST['count'])){
			die("missing parameter <i>count</i>");
		}
		if(!isset($_REQUEST['collection'])){
			die("missing parameter <i>collection</i>");
		}
		
    try{
      $resultado = $clientesoap->lastRecords($_REQUEST['count'], 
        $_REQUEST['collection']);
    }catch(Exception $e){
      die('Error: ' . $e->getMessage());
    }
    
		break;
	case "lastRecordsHG":		
		if(!isset($_REQUEST['count'])){
			die("missing parameter <i>count</i>");
		}
		if(!isset($_REQUEST['collection'])){
			die("missing parameter <i>collection</i>");
		}
		
    try{
      $resultado = $clientesoap->lastRecordsHG($_REQUEST['count'], 
        $_REQUEST['collection']);
    }catch(Exception $e){
      die('Error: ' . $e->getMessage());
    }
    
		break;
}

	header('Content-type: application/xml; charset="ISO-8859-1"',true);
	echo $resultado;
?>
