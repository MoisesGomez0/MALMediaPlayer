function h() {
	
	var lyrics1Div = document.querySelector("div#lyrics1");
	var lyrics2Div = document.querySelector("div#lyrics2");
	
	var songName= "My Way";
	var artistName = "Frank Sinatra";
	
	lyrics1Div.innerHTML = "";/**Limpia el contenido de lyrics1.*/
	$.post("Controllers/StaticLyric.jsp",{"songName": songName, "albumName": null, "artistName": artistName},function(data){
		try {
			console.group("lyrics1");
			data = JSON.parse(`${data}`.trim());
			lyrics1Div.innerHTML = data.message;
			console.log(data);
		} catch (e) {
			console.error("Fallo en la carga de las lyrics1.");
			console.log(data);
			console.groupEnd();
		}
	}).done(function(){
		console.log("Lyrics1 cargadas correctamente.");
		console.groupEnd();
	});

	/**Petición de las lyrics2*/
	lyrics2Div.innerHTML = "";/**Limpia el contenido de lyrics2.*/
	$.post("Controllers/APILyric.jsp",{"songName": songName, "albumName": null, "artistName": artistName},function(data){
		try {
			console.group("lyrics2");
			data = JSON.parse(`${data}`.trim());
			lyrics2Div.innerHTML = data.message.body.lyrics.lyrics_body; /**Agrega las lyrics al div correspondiente.*/	
			console.log(data);
		} catch (e) {
			console.error("Fallo en la carga de las lyrics2.");
			console.error(e.message);
			console.log(data);
			console.groupEnd();
		}
	}).done(function(){
		console.log("Lyrics2 cargadas correctamente.");
		console.groupEnd();
	});
}