<?php
$objSoapServer = new SoapServer('indexBVS.wsdl');
$objSoapServer->addFunction(SOAP_FUNCTIONS_ALL);
$objSoapServer->handle();

function search($expression, $from, $count, $collection){

	$from = ($from  != "" ? $from  : "1");
	$count= ($count != "" ? $count : "10");
		
	$expression = str_replace(" ","%20or%20",trim($expression));
	
	$serviceUrl = "http://".$_SERVER["HTTP_HOST"]."/cgi-bin/wxis.exe/?IsisScript=ScieloXML/fi_bvs_search.xis&database=search_".$collection."&search=".$expression."&from=".$from."&count=".$count;
	//$response = file_get_contents($serviceUrl);
	$response = $serviceUrl;
        
	return $response;
}

function searchHG($expression, $from, $count, $collection){

	$from = ($from  != "" ? $from  : "1");
	$count= ($count != "" ? $count : "10");
		
	$expression = str_replace(" ","%20or%20",trim($expression));

	$serviceUrl = "http://".$_SERVER["HTTP_HOST"]."/cgi-bin/wxis.exe/?IsisScript=ScieloXML/fi_bvs_search_hg.xis&database=search_".$collection."&search=".$expression."&from=".$from."&count=".$count;
	$response = file_get_contents($serviceUrl);
	
	return $response;
}


function advancedSearch($index, $expression, $from, $count, $collection){
	
	$from = ($from  != "" ? $from  : "1");
	$count= ($count != "" ? $count : "10");
	
	$expression = str_replace(" ","%20or%20".$index,trim($expression));
		
	$serviceUrl = "http://".$_SERVER["HTTP_HOST"]."/cgi-bin/wxis.exe/?IsisScript=ScieloXML/fi_bvs_search.xis&database=searchp_".$collection."&search=".$index.$expression."&from=".$from."&count=".$count;
	$response = file_get_contents($serviceUrl);
	
	return $response;
}

function advancedSearchHG($index, $expression, $from, $count, $collection){
	
	$from = ($from  != "" ? $from  : "1");
	$count= ($count != "" ? $count : "10");
	
	$expression = str_replace(" ","%20or%20".$index,trim($expression));
		
	$serviceUrl = "http://".$_SERVER["HTTP_HOST"]."/cgi-bin/wxis.exe/?IsisScript=ScieloXML/fi_bvs_search_hg.xis&database=searchp_".$collection."&search=".$index.$expression."&from=".$from."&count=".$count;
	$response = file_get_contents($serviceUrl);
	
	return $response;
}


function listRecords($from, $count, $collection){

	$from = ($from  != "" ? $from  : "1");
	$count= ($count != "" ? $count : "10");
		
	$serviceUrl = "http://".$_SERVER["HTTP_HOST"]."/cgi-bin/wxis.exe/?IsisScript=ScieloXML/fi_bvs_search.xis&database=search_".$collection."&search=$&from=".$from."&count=".$count;
	$response = file_get_contents($serviceUrl);
	
	return $response;
}

function lastRecords($count, $collection){
	
	$count= ($count != "" ? $count : "10");
		
	$serviceUrl = "http://".$_SERVER["HTTP_HOST"]."/cgi-bin/wxis.exe/?IsisScript=ScieloXML/fi_bvs_search.xis&database=search_".$collection."&search=$&count=".$count."&reverse=on";
	$response = file_get_contents($serviceUrl);

	return $response;
}

function lastRecordsHG($count, $collection){

	$count= ($count != "" ? $count : "10");
		
	$serviceUrl = "http://".$_SERVER["HTTP_HOST"]."/cgi-bin/wxis.exe/?IsisScript=ScieloXML/fi_bvs_search_hg.xis&database=search_".$collection."&search=$&count=".$count."&reverse=on";
	$response = file_get_contents($serviceUrl);

	return $response;
}
?>