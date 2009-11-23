function swapImage (obj, nsource) {
	var img;
	img = document.getElementById(obj);
	img.src = nsource;
}

function doImage (obj, nsource) {
	var img;
	img = document.getElementById(obj);
	img.src = nsource;
}

function conflirmDelete(url,question) {
	if (confirm(question)) {
		window.location = url;
	} else {
	  return false;
	}
}

function lightingStars(id,rate) {
	if (rate == 1) {
		doImage('star'+id+'_1','../image/public/skins/classic/common/starOn.gif');
		doImage('star'+id+'_2','../image/public/skins/classic/common/starOff.gif');
		doImage('star'+id+'_3','../image/public/skins/classic/common/starOff.gif');
	}else if (rate == 2) {
		doImage('star'+id+'_1','../image/public/skins/classic/common/starOn.gif');
		doImage('star'+id+'_2','../image/public/skins/classic/common/starOn.gif');
		doImage('star'+id+'_3','../image/public/skins/classic/common/starOff.gif');
	}else if (rate == 3) {
		doImage('star'+id+'_1','../image/public/skins/classic/common/starOn.gif');
		doImage('star'+id+'_2','../image/public/skins/classic/common/starOn.gif');
		doImage('star'+id+'_3','../image/public/skins/classic/common/starOn.gif');
	}

}
/*Funcoes do Tracker do SGU*/

function readCookie(name) {
	var nameEQ = name + "=";
	var ca = document.cookie.split(';');
	for(var i=0;i < ca.length;i++) {
		var c = ca[i];
		while (c.charAt(0)==' ') c = c.substring(1,c.length);
		if (c.indexOf(nameEQ) == 0) return c.substring(nameEQ.length,c.length);
	}
	return null;
}

function tracker()
{
	try{
		var tokenVisit = readCookie("tokenVisit");

		if (  tokenVisit != null )
		{
			var location = document.location;
			var referrer = document.referrer;

			var xmlhttp=false;

			try
			{
				xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
			}
			catch (e)
			{
				try
				{
					xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				}
				catch (E)
				{
					xmlhttp = false;
				}
			}

			if (!xmlhttp && typeof XMLHttpRequest!='undefined')
			{
				xmlhttp = new XMLHttpRequest();
			}

			var url = "http://scielo-org.dev:8085/sgu_webservice/control/sguHits?tokenVisit="+tokenVisit+"&location="+location+"&referrer="+referrer;

			xmlhttp.open("GET", url, true);
			xmlhttp.send(null);
		}
	}catch(E){
		alert(E);
	}
}

/*End : Funcoes do Tracker do SGU*/