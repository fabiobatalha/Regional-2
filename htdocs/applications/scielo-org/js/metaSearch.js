function changeInstanceIndexes(instance){
//	alert(instance);
//	var where = document.getElementById("where");	
	instanceTotal = document.searchForm.where.options.length;

	for (i=0 ; i<instanceTotal ; i++){
		var inst = document.getElementById("instance_"+(i+1));
		inst.style.display="none"; 
	}
	inst = document.getElementById("instance_"+(instance+1));
	inst.style.display="block"; 
}