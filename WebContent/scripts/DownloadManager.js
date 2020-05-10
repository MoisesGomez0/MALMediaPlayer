/**
 * Administra el proceso de descarga de archivos.
 */
function DownloadManager(){
	this.downloadList = []; /**Lista de canciones a descargar.*/

	/**
	 * Muestra la lista de canciones a desecargar dentro del objeto HTML específicado.
	 * @param obj objeto HTML al que se le agregará la información de la lista.
	 */
	this.showDownloadList = function(obj = document.querySelector("div#downloadList")) {
		var overlay = document.querySelector("div#overlayDownload"); /**Div que contiene la lista.*/
		obj.innerHTML = ""; /**Limpia el contenedor de la lista. */

		for (let fileName of this.downloadList) { /**Agrega todas las canciones en la lista de descarga.**/
			
			obj.innerHTML += `<input type="checkbox" onchange="sbm.checkBoxAction(this);" id="${fileName}" value="${fileName}" checked>`
			obj.innerHTML += `<label id="${fileName}" class="musicSelectorLabel" onclick="console.log(this.id);vm.setInfo(this.id);"> ${fileName}</label><br>`
		}
		
		overlay.style.zIndex = 2;
		overlay.style.visibility = "visible";
		return false;
	}

	/**
	 * Oculta la lista de descarga.
	 */
	this.hideDownloadList = function() {
		var overlay = document.querySelector("div#overlayDownload"); /**Div que contiene la lista.*/
		overlay.style.zIndex = -1;
		overlay.style.visibility = "hidden";
		return false;
	}

	/**
	 * Obtiene la lista de canciones a descargar desde una sensión en el servidor. 
	 */
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
		if (this.downloadList.length != 0){
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
}

function ModelManager(){
	
	this.hide = function(selector = "div#overlayAbout"){
		document.querySelector(selector).style.zIndex = -1;
	}

	this.show = function(selector = "div#overlayAbout"){
		document.querySelector(selector).style.zIndex = 2;
	}
	
	
}