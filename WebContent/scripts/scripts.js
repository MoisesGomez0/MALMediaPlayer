
function SearchBarManager(){
	
	var timeOut;
	this.change = function(obj){
		clearTimeout(timeOut);
		timeOut = setTimeout(function(){
			console.log(obj.value)
			$.post("Controllers/Search.jsp",{"search":obj.value},function(data){
				data = JSON.parse(`${data}`.trim());
				console.log(data);
			});
		},1000);
	}
}

