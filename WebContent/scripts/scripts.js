function SearchBarManager(){
	
	/**
	 * Genera el selector de canciones con las canciones buscadas.
	 * @param {input_tag} obj Barra de busqueda de la que depende.
	 * @param {list} Contenido del selector de canciones.
	 */
	this.showMusicSelector = function(obj, data){
		obj.innerHTML = "";
		for (let song of data.message.songs) {
			let artist = song.artist;
			let album = song.album;
			let songName = song.name;
			let fileName = song.fileName;
			
			obj.innerHTML += `<input type="checkbox" id="${artist}_${album}_${songName}" value="${fileName}">`
			obj.innerHTML += `<label onclick="console.log('Reproduce la canción')"> ${artist}-${album}-${songName}</label><br>`
		}
			
	}
	
	this.hideMusicSelector = function(obj){
		
	}
	
	var timeOut;
	this.change = function(obj){
		clearTimeout(timeOut);
		timeOut = setTimeout(function(){
			console.log(obj.value);
			$.post("Controllers/Search.jsp",{"search":obj.value},function(data){
				data = JSON.parse(`${data}`.trim());
				console.log(data);
				sbm.showMusicSelector(document.querySelector("div#musicSelector"),data);
			});
		},1000);
	}
}

function SessionManager(){
	this.showLoginPopup = function(){
		
	}
}