function SearchBarManager(){
	
	/**
	 * Genera el selector de canciones con las canciones buscadas.
	 * @param {input_tag} obj Barra de busqueda de la que depende.
	 * @param {list} Contenido del selector de canciones.
	 */
	this.showMusicSelector = function(data,obj = document.querySelector("div#musicSelector")){
		obj.style.zIndex = 1; /**Muestra el objeto*/
		obj.innerHTML = ""; /**Empieza sin valores*/
		for (let song of data.message.songs) { /**Agrega todas las canciones encontradas por el servidor.**/
			let artist = song.artist;
			let album = song.album;
			let songName = song.name;
			let fileName = song.fileName;
			
			obj.innerHTML += `<input type="checkbox" id="${fileName}" value="${fileName}">`
			obj.innerHTML += `<label onclick="console.log('Reproduce la canción')"> ${artist}-${album}-${songName}</label><br>`
		}
			
	}
	
	this.hideMusicSelector = function(obj = document.querySelector("div#musicSelector")){
		obj.style.zIndex = -1;
	}
	
	var timeOut;
	this.change = function(obj){
		clearTimeout(timeOut);
		timeOut = setTimeout(function(){
			console.log(obj.value);
			$.post("Controllers/Search.jsp",{"search":obj.value},function(data){
				data = JSON.parse(`${data}`.trim());
				console.log(data);
				sbm.showMusicSelector(data);
			});
		},300);
	}
}

function MusicListManager(){
	
	/**
	 * Agrega todos los albums encontrados por el servidor al div correspondiente.
	 */
	this.albumsData = function(){
		var obj = document.querySelector("div#albums");
		obj.innerHTML = ""; /**Limpia el contenido.*/
		$.post("Controllers/getAlbums.jsp",{},function(data){
			data = JSON.parse(`${data}`.trim());
			for (let album of data.message.albums) {
				obj.innerHTML += `<label> ${album}</label><br>`;
			}
		});
	}
	
	/**
	 * Agrega los nombres de los artistas encontrados por el servidor al div correspondiente.
	 */
	this.artistsData = function(){
		var obj = document.querySelector("div#artists");
		obj.innerHTML = ""; /**Limpia el contenido.*/
		$.post("Controllers/getAllArtists.jsp",{},function(data){
			data = JSON.parse(`${data}`.trim());
			for (let artist of data.message.albums) {
				obj.innerHTML += `<label> ${artist}</label><br>`;
			}
		});
	}
}


function SessionManager(){
	this.showLoginPopup = function(){
		
	}
}

