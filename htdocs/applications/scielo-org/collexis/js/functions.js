
function showhideLayers(obj,path, image) 
{ //v1.0
	var v,obj;	
	if ( image != ''){
		image=MM_findObj(image);
	}	
	
	if ((obj=MM_findObj(obj))!=null) 
	{
        v=obj.style.display;
        if (v == 'none' ) 
		{
                disp = 'block';
				img = path + '/retract.gif';
        }
        else 
		{
                disp = 'none';
				img = path + '/expand.gif';
        }
        obj.style.display = disp;
		if ( image != ''){
			image.src = img;
		}	
 }
}

function MM_showhideLayers()
{ 
        var i,p,v,obj,args=MM_showhideLayers.arguments;
                for (i=0; i<(args.length-2); i+=3)
                        if ((obj=MM_findObj(args[i]))!=null)
                        {
                                v=args[i+2];
                                if (obj.style)
                                {
                                        obj=obj.style;
										v=(v=='show')?'block':(v=='hide')?'none':v;
                                }
                                obj.display=v;
                        }
}

function MM_findObj(n, d)
{ //v4.01
        var p,i,x; if(!d) d=document;
        if((p=n.indexOf("?"))>0&&parent.frames.length)
        {
                d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);
        }
        if(!(x=d[n])&&d.all)
                x=d.all[n];
        for (i=0;!x&&i<d.forms.length;i++)
                x=d.forms[i][n];
                for(i=0;!x&&d.layers&&i<d.layers.length;i++)
                        x=MM_findObj(n,d.layers[i].document);
                if(!x && d.getElementById)
                        x=d.getElementById(n);
        return x;
}

function openWindow ( url ){
	var d = new Date();
	var winId = d.getDate() + d.getHours() + d.getMinutes() + d.getSeconds();
	
	//newWindow = window.open(url, winId , 'scrollbars=yes, top=20, left=230, width=565, height=520');
	newWindow = window.open(url, winId , '');
	newWindow.focus();
	return;
}

function checkUncheck( group, status  ) 
{
	 var fieldList = document.metasearch.elements;
     var fieldId;
     var pos;
	 
     for ( i = 0; i < fieldList.length; i++ )
     {
		field = fieldList[i];
	 	
		if ( field.type != 'checkbox' ){
		   continue;
		}
	    
	    if ( group == "all" ) {
       	
		    field.checked = true;
           
		} else {
		
             fieldId = field.id;
             pos = group.length;

             if ( fieldId.substring(0,pos) == group ){
			   
	                 field.checked = status;
	           
             }           
       }
 	}  
	return;
}



function postHref ( href, target){
		
	var hrefAction = href.substring(0,href.indexOf('?'));
	var hrefParameters = href.substring(href.indexOf('?')+1);
	var splitedHref = hrefParameters.split("&");
	var qtt = splitedHref.length;
	var splitedHidden = new Array();
	var hiddenName = "";
	var hiddenValue = "";
	var submitForm = document.formHref;

	if ( target == '' || !target ){
		target = 'postHref';
	}	
	
	submitForm.action = hrefAction;
	submitForm.target = target;
	
	for ( var i = 0; i < qtt; i++ )
	{
		splitedHidden = splitedHref[i].split("=");
		hiddenName = splitedHidden[0];
		splitedHidden[0] = "";
		hiddenValue = splitedHidden.join("=");
		hiddenValue = hiddenValue.replace(/%20/g,' ');
		hiddenValue = hiddenValue.replace(/%2F/g,'/');
		hiddenValue = hiddenValue.replace(/\+/g,' ');

		submitForm.elements[i].name = hiddenName;
		submitForm.elements[i].value = hiddenValue.substring(1);
	}
	
	//resultWindow = window.open('about:blank',target);
	//resultWindow.focus();

	submitForm.submit();
	// realizar testes de compatibilidade do codigo abaixo	
	resultWindow = window.open('',target);		
	resultWindow.focus();	
}


function refineSearch(){

	refineForm = document.formSearch;
	refineForm.action = pSCRIPTS + "/page_show_main.php";
	refineForm.submit();
	return;

}

function openDeCS(){

	lang = document.metasearch.lang.value;
	if (lang == "pt"){ decsLang = "p"; }
	if (lang == "es"){ decsLang = "e"; }
	if (lang == "en"){ decsLang = "i"; }
	
	decsUrl = "http://decs.bvs.br/cgi-bin/wxis1660.exe/decsserver/?IsisScript=../cgi-bin/decsserver/decsserver.xis&interface_language=" + decsLang + "&previous_page=homepage&previous_task=NULL&task=start";
	decsWindow = window.open(decsUrl, "decs", "height=550,width=750,menubar=yes,toolbar=yes,location=no,resizable=yes,scrollbars=yes,status=no");
	decsWindow.focus();
	
	return;
	
}

function showDeCSTerm( id ){
	
	lang = document.formSearch.lang.value;
	if (lang == "pt"){ decsLang = "p"; }
	if (lang == "es"){ decsLang = "e"; }
	if (lang == "en"){ decsLang = "i"; }
	
	decsUrl = "http://decs.bvs.br/cgi-bin/wxis1660.exe/decsserver/?IsisScript=../cgi-bin/decsserver/decsserver.xis&interface_language=" + decsLang + "&search_language=" + decsLang + "&previous_page=homepage&task=exact_term&search_exp=mfn=" + id + "#RegisterTop";
	decsWindow = window.open(decsUrl, "decsTerm", "height=450,width=630,menubar=yes,toolbar=yes,location=no,resizable=yes,scrollbars=yes,status=no");
	decsWindow.focus();
	
	return;
}

function changeLang(lang, home ){
	form = document.formMain;
	form.lang.value = lang;	
	if (home == "true"){
		form.task.value = 'init';
	}	
	form.submit();
	return;
}


function homePage(){
	form = document.formMain;
	form.task.value = 'init';

	form.submit();
	return;
}


function show_fingerprint(_id){
	
	form = document.formMain;
	_collection = form.collection.value;  
	_lang = form.lang.value;
	_thesaurus  = form.thesaurus.value;	

	fpUrl = PATH_DATA + "index.php?task=show_fingerprint&collection=" + _collection + "&thesaurus=" + _thesaurus + "&lang=" + _lang + "&sid=" + _id; 
	fpWindow = window.open(fpUrl, "fingerprint", "height=450,width=410,menubar=no,toolbar=no,location=no,resizable=yes,scrollbars=yes,status=no");

	fpWindow.moveTo(250,150);
	fpWindow.focus();

	return;
}

function new_search(){
	form = document.formMain;
	form.task.value = 'init';
	form.expression.value = '';
	form.submit();
	return;
}

function find_similar(id){
	form = document.formMain;
	form.task.value = 'related';
	form.related_id.value = id;
	
	form.submit();
	return;
}

function add_concept_id(id){
	formFP  = document.formFingerPrint;
	formAdd = document.formAddConcept;
	formFP.add_concept_id.value = id;
	formFP.add_concept_thesaurus.value = formAdd.add_concept_thesaurus.value;
	
	formFP.submit();
	return;
}

function add_concept_name(){
	formFP = document.formFingerPrint;
	formAdd = document.formAddConcept;	
	formFP.add_concept_name.value = formAdd.add_concept.value;
	formFP.add_concept_thesaurus.value = formAdd.add_concept_thesaurus.value;
	
	formFP.submit();
	return;
}


function go_document(position){
	form = document.formMain;
	form.from.value = position;
	
	form.submit();
	return;
}

function show_refDB( refDB,refID ){
	
	form = document.formMain;
	lang = form.lang.value;
	if (lang == "pt"){ oneLetterLang = "p"; }
	if (lang == "es"){ oneLetterLang = "e"; }
	if (lang == "en"){ oneLetterLang = "i"; }


	switch (refDB){
		case "LIS" :
			refUrl = "http://lis.bvs.br/xml2html/xmlListT.php?xml[]=http://lis.bvs.br/lis-Regional/" +  oneLetterLang.toUpperCase() + "/define.xml&xmlForm[]=no&xml[]=http://lis.bvs.br/cgi-bin/wxis.exe/lis-Regional/?IsisScript=iyp/iyp.xis&iyp_def=lis-Regional.def&lang=" + oneLetterLang.toUpperCase() + "&xmlForm[]=yes&xsl=http://lis.bvs.br/lis-Regional/browse.xsl&enter.x=1&newexpr=ID=" + refID;
			break;
		default : 
			refUrl = "http://bases.bireme.br/cgi-bin/wxislind.exe/iah/online/?IsisScript=iah/iah.xis&base=" + refDB + "&lang=" + oneLetterLang + "&nextAction=lnk&exprSearch=" + refID + "&indexSearch=ID" + "&ref=collexis#1";
	} 
		
	refWindow = window.open(refUrl, "reference", "height=490,width=630,menubar=yes,toolbar=yes,location=no,resizable=yes,scrollbars=yes,status=no");
	refWindow.focus();
	
	return;
}

