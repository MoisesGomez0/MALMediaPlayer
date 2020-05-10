/**
 * Realiza las acciones del audio.
 */
function MusicPlayer(){

	this.musicList = []; /**Lista de canciones que va seleccionando el usuario para escuchar. */
	this.current = ""; /**Canción actual. */

	/**
	 * Selecciona una nueva canción como actual.
	 */
	this.setCurrent = function(current){
 
		if (!this.musicList.includes(current)){
			this.musicList.push(current);
		}
		this.current = current;

	}

	/**
	 * Reproduce la canción anterior de current en la lista.
	 */
	this.previous = function(){
		if (this.musicList.length > 1 && this.musicList.indexOf(this.current) != 0){
			this.current = this.musicList[this.musicList.indexOf(this.current) - 1];
			vm.setInfo(this.current);
			vm.showInfo();

		}
	}
	/**
	 * Reproduce la canción depués de current en la lista.
	 */
	this.next = function() {
		if (this.musicList.length > 1 && this.musicList.indexOf(this.current) != this.musicList.length - 1){
			this.current = this.musicList[this.musicList.indexOf(this.current) + 1];
			vm.setInfo(this.current);
			vm.showInfo();
		}

	}

	/**
	 * Limpia la lista de reproducción,
	 */
	this.clearList = function() {
		this.musicList = [];
	}
}