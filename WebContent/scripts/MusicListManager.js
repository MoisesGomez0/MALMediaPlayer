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