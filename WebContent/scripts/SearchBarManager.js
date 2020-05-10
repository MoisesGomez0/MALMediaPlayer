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
		obj.style.visibility = "visible";

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
		obj.style.visibility = "hidden";
		
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
