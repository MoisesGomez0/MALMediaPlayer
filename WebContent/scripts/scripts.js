/**
 * Maneja todas las acciones que tiene que ralizar la barra de búsqueda.
 * 
 */
function SearchBarManager(){
	this.songList = [];
	/**
	 * Genera el selector de canciones con las canciones buscadas.
	 * @param {div} obj Div que representa al MusicSelector.
	 * @param {list} Contenido del selector de canciones.
	 */
	this.showMusicSelector = function(data,obj = document.querySelector("div#musicSelector")){

		obj.style.zIndex = 1; /**Muestra el objeto*/
		this.songList = []; /**Limpia la lista de canciones.*/
		obj.innerHTML = ""; /**Empieza sin valores*/
		
		for (let song of data.message.songs) { /**Agrega todas las canciones encontradas por el servidor.**/
			let artist = song.artist;
			let album = song.album;
			let songName = song.name;
			let fileName = song.fileName;
			
			if (dm.downloadList.includes(fileName)){ /**Si ya está en la lista de descargas. */
				/**La checkbox estará checked. */
				obj.innerHTML += `<input type="checkbox" onchange="sbm.checkBoxAction(this);" id="${fileName}" value="${fileName}" checked>`
			}else{
				obj.innerHTML += `<input type="checkbox" onchange="sbm.checkBoxAction(this);" id="${fileName}" value="${fileName}">`
			}
			
			obj.innerHTML += `<label id="${fileName}" class="musicSelectorLabel" onclick="vm.setInfo(this.id);"> ${artist}-${album}-${songName}</label><br>`
		}
		
		return false;		
	}

	/**
	 * Acción que se realiza cuando un checkbox cambia de estado.
	 */
	this.checkBoxAction = function(obj){
		console.group("CheckBoxAction");
		var checked = obj.checked; /**Indica si el checkBox tiene un check.*/
		var fileName = obj.id; /**El nombre del archivo que teien como id el checkbox. */

		console.log(checked);
		console.log(fileName);

		/**Si la lista de descargas está vacía o la canción no ha sido seleccionada y está en check. */
		console.group("case 1");
		if ((dm.downloadList.length == 0 || !dm.downloadList.includes(fileName)) && checked){
			console.log(dm.downloadList.length == 0);
			console.log((dm.downloadList.length == 0 || !dm.downloadList.includes(fileName)) && checked);
			
			dm.downloadList.push(fileName);
			$.post("Controllers/DownloadList.jsp",{"action": "add", "name": fileName},null);
			console.log(dm.downloadList);
		}
		console.groupEnd();

		/**Si la canción está en la lista y no está checked */
		console.group("case 2");
		if (dm.downloadList.includes(fileName) && !checked){
			console.log(dm.downloadList.length == 0);
			console.log((dm.downloadList.length == 0 || !dm.downloadList.includes(fileName)) && checked);
			
			dm.downloadList.splice(dm.downloadList.indexOf(fileName),1); /**Elimina la canción de la lista de descargas. */
			$.post("Controllers/DownloadList.jsp",{"action": "del", "name": fileName},null);

			console.log(dm.downloadList);
		}
		console.groupEnd();

		console.groupEnd();
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
		var val;

		if(!obj.value){
			val = obj.innerHTML;
		}else{
			val = obj.value; 
		}

		clearTimeout(timeOut);
		timeOut = setTimeout(function(){
			$.post("Controllers/Search.jsp",{"search":val},function(data){
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
				obj.innerHTML += `<label class="listLabel" onclick="sbm.change(this);"> ${album}</label><br>`;
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
				obj.innerHTML += `<label class="listLabel" onclick="sbm.change(this);"> ${artist}</label><br>`;
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

	this.loadingGifPath = "styles/images/loading.gif"
	
	this.closeInfo = function(){
		var mainInfo = document.querySelector("div#mainInfo");
		var mainArt = document.querySelector("div#mainArt");
		var audio = document.querySelector("audio#audioTag");

		audio.pause();
		audio.src = "";
		
		mainInfo.style.width = 0;
		mainInfo.style.height = 0;

		mainArt.style.width = "100%";
		mainArt.style.height = "100%";

		return false;
	}

	this.homeAction = function(){
		this.closeInfo();
		mp.clearList(); /**Elimina la lista de canciones seleccionadas. */
	}

	this.showInfo = function(){
		var mainInfo = document.querySelector("div#mainInfo");
		var mainArt = document.querySelector("div#mainArt");

		mainArt.style.width = 0;
		mainArt.style.height = 0;

		mainInfo.style.width = "100%";
		mainInfo.style.height = "100%";

		return false;
	}


	/**Carga la información de la canción a los divs correspondientes.*/
	this.setInfo = function(fileName){
		var musicNameDiv = document.querySelector("div#songName");
		var albumImage = document.querySelector("img#albumImage");
		var lyrics1Div = document.querySelector("div#lyrics1");
		var lyrics2Div = document.querySelector("div#lyrics2");

		var audio = document.querySelector("audio#audioTag");

		var name = fileName.replace(".mp3","");
		var songName = name.split("_")[2];
		var artistName = name.split("_")[0];
		var albumName = name.split("_")[1];
		
		this.musicName = `${artistName} - ${albumName} - ${songName}`; /**Obtiene el nombre completo de la canción.*/
		musicNameDiv.innerHTML = this.musicName; /**Agrega el nombre al div correspondidente.*/
		
		console.group("Requests")
		/**Petición de las lyrics1.*/
		lyrics1Div.innerHTML = "";/**Limpia el contenido de lyrics1.*/
		lyrics1Div.style.backgroundImage = `url('${this.loadingGifPath}')`;
		$.post("Controllers/StaticLyric.jsp",{"songName": songName, "albumName": albumName, "artist": artistName},function(data){
			try {
				console.group("lyrics1");
				data = JSON.parse(`${data}`.trim());
				lyrics1Div.style.backgroundImage = "";
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

		/**Petición de las lyrics2*/
		lyrics2Div.innerHTML = "";/**Limpia el contenido de lyrics2.*/
		lyrics2Div.style.backgroundImage = `url('${this.loadingGifPath}')`; /** */
		$.post("Controllers/APILyric.jsp",{"songName": songName, "albumName": albumName, "artist": artistName},function(data){
			try {
				console.group("lyrics2");
				data = JSON.parse(`${data}`.trim());
				lyrics2Div.style.backgroundImage = ""; /** */
				if (data.message.header.status_code == 404){
					lyrics2Div.innerHTML = "Lyrics not found.";
				}else{
					lyrics2Div.innerHTML = data.message.body.lyrics.lyrics_body; /**Agrega las lyrics al div correspondiente.*/	
				}
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
		
		/**Petición de la imagen del album y el archivo mp3 de la canción.*/
		albumImage.src = this.loadingGifPath;
		audio.src=""; /**Limpia el audio. */
		mp.setCurrent(fileName);
		$.post("Controllers/Play.jsp",{"fileName": fileName},function(data){
			try {
				console.group("Play");
				data = JSON.parse(`${data}`.trim());

				if (data.message.albumPath){
					albumImage.src = data.message.albumPath; /**Agrega la dirección donde se encuentra la imagen*/
				}else{
					albumImage.src = "styles/images/defaultAlbum.jpg";
				}

				audio.src = data.message.songPath;


				console.log(data);
				console.log(audio.src);
			} catch (e) {
				console.error("Fallo en la carga de la imagen del álbum o audio");
				console.log(data);
				console.groupEnd();
			}
		}).done(function(){
			console.log("Imagen del álbum cargadas correctamente.");
			console.groupEnd();
		});

		this.showInfo();
		
		return false;
	}
}

/**
 * Realiza las acciones del audio.
 * @returns
 */
function MusicPlayer(){

	this.musicList = [];
	this.current = "";
	var audio = document.querySelector("audio#audioTag");

	console.group("Controls");
	this.setCurrent = function(current){
		console.log(`SetCurrent: ${current}`);
		if (!this.musicList.includes(current)){
			this.musicList.push(current);
		}
		this.current = current;
		console.log(`list: ${this.musicList}`);

	}

	this.previous = function(){
		console.log(`Prev: ${musicList}`);
		if (this.musicList.length > 1 && this.musicList.indexOf(this.current) != 0){
			console.log("dentro");
			this.current = this.musicList[this.musicList.indexOf(this.current) - 1];
			vm.setInfo(this.current);
			vm.showInfo();

		}
	}
	
	this.next = function() {
		console.log(`Next: ${musicList}`);
		if (this.musicList.length > 1 && this.musicList.indexOf(this.current) != this.musicList.length - 1){
			console.log("dentro");
			this.current = this.musicList[this.musicList.indexOf(this.current) + 1];
			vm.setInfo(this.current);
			vm.showInfo();
		}

	}

	/**
	 * Limpia la lista de reproducción
	 */
	this.clearList = function() {
		this.musicList = [];
	}

	console.groupEnd();
}

/**
 * Administra el proceso de descarga de archivos.
 */
function DownloadManager(){
	this.downloadList = []; /**Lista de canciones a descargar.*/

	this.showDownloadList = function(obj = document.querySelector("div#downloadList")) {
		var overlay = document.querySelector("div#overlayDownload"); /**Div que contiene la lista.*/
		obj.innerHTML = ""; /**Limpia el contenedor de la lista. */

		for (let fileName of this.downloadList) { /**Agrega todas las canciones en la lista de descarga.**/
			
			obj.innerHTML += `<input type="checkbox" onchange="sbm.checkBoxAction(this);" id="${fileName}" value="${fileName}" checked>`
			obj.innerHTML += `<label id="${fileName}" class="musicSelectorLabel" onclick="console.log(this.id);vm.setInfo(this.id);"> ${fileName}</label><br>`
		}
		
		overlay.style.zIndex = 2;
		return false;
	}

	this.hideDownloadList = function() {
		var overlay = document.querySelector("div#overlayDownload"); /**Div que contiene la lista.*/
		overlay.style.zIndex = -1;
		return false;
	}

	this.loadDownloadList = function(listStr){

		$.post("Controllers/DownloadList.jsp",{"action": "get"},function(data){
			console.group("loadDownList");
			data = JSON.parse(`${data}`.trim());
			console.log(data);
			dm.downloadList = data.message.split("@");
			console.groupEnd();
		});

		return false;
	}

	/**
	 * Inicia la compresión y descarga de las canciones en la downloadList.
	 */
	this.startDownload = function(){
		var downloadLink = document.querySelector("a#downloadLink"); /**Anchor tag que comenzará la descarga. */
		var parameterValue = this.downloadList.join("@");
		
		$.post("Controllers/Download.jsp",{"files": parameterValue},function(data){

			data = JSON.parse(`${data}`.trim());

			console.group("Download");
			console.log(`Parameter files: ${parameterValue}`);
			console.log(`Data: ${data}`);
			console.groupEnd();

			downloadLink.href = data.message; /**Guarda el link de descarga. */
			downloadLink.click(); /**Inicia la descarga. */
			downloadLink.href = ""; /**Elimina el link de descarga. */
		});

	}


}

