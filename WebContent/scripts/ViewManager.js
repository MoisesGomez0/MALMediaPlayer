/**
 * Maneja la información que se mostrará de la canción.
 */
function ViewManager(){
	this.musicName = "";

	this.loadingGifPath = "styles/images/loading.gif"
	
	/**
	 * Cierra la información y muestra el arte principal de la aplicación.
	 */
	this.closeInfo = function(){
		var mainInfo = document.querySelector("div#mainInfo");
		var mainArt = document.querySelector("div#mainArt");
		var audio = document.querySelector("audio#audioTag");

		audio.pause();
		audio.src = "";
		
		mainInfo.style.width = 0;
		mainInfo.style.height = 0;
		mainInfo.style.visibility = "hidden";
		
		mainArt.style.width = "100%";
		mainArt.style.height = "100%";
		mainArt.style.visibility = "visible";

		return false;
	}

	/**
	 * Vuelve a la pantalla principal de la aplicación borrando la lista de reproducción
	 * anterior.
	 */
	this.homeAction = function(){
		this.closeInfo();
		mp.clearList(); /**Elimina la lista de canciones seleccionadas. */
	}

	/**
	 * Muestra la información de la canción actual cerrando la pantalla que muestra el arte
	 * de la aplicación,
	 */
	this.showInfo = function(){
		var mainInfo = document.querySelector("div#mainInfo");
		var mainArt = document.querySelector("div#mainArt");

		mainArt.style.width = 0;
		mainArt.style.height = 0;
		mainArt.style.visibility = "hidden";

		mainInfo.style.width = "100%";
		mainInfo.style.height = "100%";
		mainInfo.style.visibility = "visible";

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
