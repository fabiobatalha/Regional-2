var xmlHttp = false;
var metaengine = "";
var rateResult = "";

function httpInit() 
{


   		if (window.XMLHttpRequest) { // Mozilla, Safari,...
        	xmlHttp = new XMLHttpRequest();
	        if (xmlHttp.overrideMimeType) {
            	xmlHttp.overrideMimeType('text/xml');                
         	}
     	}else if (window.ActiveXObject) { // IE
        	try {
           		xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
        	}
			catch (e){
        		try {
        			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
        		}catch (e) {}
        	}
     	}
		if (!xmlHttp) {
    	   	alert('Cannot create an XMLHTTP instance');
       		return false;
    	}

	
}

function callUpdateArticleRate(shelf,rate){	
// inicializing XMLHttpRequest
 httpInit();
 var url = "../users/changeArticleRate.php?shelf=" + shelf + "&rate=" + rate;
   	xmlHttp.open("POST", url, true);
    xmlHttp.onreadystatechange = UpdateRate;  
    xmlHttp.send(null);

}

function callUpdateLinkRate(_link,rate){	
//alert("here "+_link+" rate "+rate);
// inicializing XMLHttpRequest
 httpInit();
 var url = "../users/changeLinkRate.php?link=" + _link + "&rate=" + rate;
   	xmlHttp.open("POST", url, true);
    xmlHttp.onreadystatechange = UpdateRate;  
    xmlHttp.send(null);

}

function UpdateRate(){
    //var resultPortlet = document.getElementById("searchResult");
    //var result = document.getElementById("result");
    //var buffer = "";
    //resultPortlet.style.display="block"; 

    //result.innerHTML = "<div align='center'><img src='../image/common/loading.gif' border='0'></div>";

    if (xmlHttp.readyState == 4) {			
        if (xmlHttp.status == 200) {		
      	    //var responseXml = xmlHttp.responseXML;
   			var responseText = xmlHttp.responseText;
			rateResult = responseText;
        }
    }
}

function httpClose(){
	xmlHttp.abort();
}
function portletClose(portletId){
	httpClose();
    var portlet = document.getElementById(portletId);
    portlet.style.display = "none";
    return;
}