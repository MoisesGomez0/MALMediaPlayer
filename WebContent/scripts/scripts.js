/**
 * Maneja todas las acciones que tiene que ralizar la barra de búsqueda.
 * 
 */
function SearchBarManager(){
	/**
	 * Genera el selector de canciones con las canciones buscadas.
	 * @param {div} obj Div que representa al MusicSelector.
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
			obj.innerHTML += `<label id="${fileName}" class="musicSelectorLabel" onclick="console.log(this.id);vm.setInfo(this.id);"> ${artist}-${album}-${songName}</label><br>`
		}
		
		return false;
			
	}
	
	/**
	 * Esconde el selector de canciones.
	 */
	this.hideMusicSelector = function(obj = document.querySelector("div#musicSelector")){
		obj.style.zIndex = -1;
		
		return false;
	}
	
	/***
	 * Realiza una acción cuando hay un cambio en la barra de búsqueda.
	 */
	var timeOut;
	this.change = function(obj){
		clearTimeout(timeOut);
		timeOut = setTimeout(function(){
			$.post("Controllers/Search.jsp",{"search":obj.value},function(data){
				data = JSON.parse(`${data}`.trim());
				sbm.showMusicSelector(data);
			});
		},300);
		
		return false;
	}
}

/**
 * Maneja el contenido y las acciones del div que contiene la lista de albums y artistas.
 */
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
		
		return false;
	}
	
	/**
	 * Agrega los nombres de los artistas encontrados por el servidor al div correspondiente.
	 */
	this.artistsData = function(){
		var obj = document.querySelector("div#artists");
		obj.innerHTML = ""; /**Limpia el contenido.*/
		$.post("Controllers/getAllArtists.jsp",{},function(data){
			data = JSON.parse(`${data}`.trim());
			for (let artist of data.message.artists) {
				obj.innerHTML += `<label> ${artist}</label><br>`;
			}
		});
		
		return false;
	}
}


/**
 * Maneja la información de la canción.
 * @returns
 */
function ViewManager(){
	this.musicName = "";
	
	/**Carga la información de la canción a los divs correspondientes.*/
	this.setInfo = function(fileName){
		var musicNameDiv = document.querySelector("div#songName");
		var albumImage = document.querySelector("img#albumImage");
		var lyrics1Div = document.querySelector("div#lyrics1");
		
		var name = fileName.replace(".mp3","");
		var songName = name.split("_")[2];
		var artistName = name.split("_")[0];
		var albumName = name.split("_")[1];
		
		this.musicName = `${artistName} - ${albumName} -${songName}`; /**Obtiene el nombre completo de la canción.*/
		musicNameDiv.innerHTML = this.musicName; /**Agrega el nombre al div correspondidente.*/
		
		console.group("Requests")
		/**Petición de las lyrics1.*/
		lyrics1Div.innerHTML = "";/**Limpia el contenido de lyrics1.*/
		$.post("Controllers/StaticLyric.jsp",{"songName": songName, "albumName": albumName, "artist": artistName},function(data){
			try {
				console.group("lyrics");
				data = JSON.parse(`${data}`.trim());
				lyrics1Div.innerHTML = data.message; /**Agrega las lyrics al div correspondiente.*/	
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
		
		/**Petición de la imagen del album y el archivo mp3 de la canción.*/
		$.post("Controllers/Play.jsp",{"fileName": fileName},function(data){
			try {
				console.group("Play");
				data = JSON.parse(`${data}`.trim());
				if (data.message.albumPath){
					albumImage.src = data.message.albumPath; /**Agrega la dirección donde se encuentra la imagen*/
				}
				
				document.querySelector("video#musicBar").src = data.message.songPath;
				
				console.log(data);
			} catch (e) {
				console.error("Fallo en la carga de la imagen del álbum");
				console.log(data);
				console.groupEnd();
			}
		}).done(function(){
			console.log("Imagen del álbum cargadas correctamente.");
			console.groupEnd();
		});
		
		
		return false;
	}
}

/**
 * 
 * @param fileName
 * @returns
 */
function MusicPlayer(){
	this.audio = new Audio();
	
	this.updateAudioSrc = function(data){
		this.audio.src = data;
	}
	
	this.setAudioSrc = function(){
		
	}
	
}

function SessionManager(){
	this.showLoginPopup = function(){
		
	}
}


