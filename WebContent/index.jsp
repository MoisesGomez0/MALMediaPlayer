<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="styles/index.css">

<script src="jquery-3.4.1.min.js"></script>
<script src="scripts/scripts.js"></script>

<script>

	var sbm = new SearchBarManager();
	var mlm = new MusicListManager();
	var mp = new MusicPlayer();
	var vm = new ViewManager();
	var dm = new DownloadManager();
	
</script>

</head>
<body onload="mlm.albumsData(); mlm.artistsData();">
	
	<div id="musicSelector"></div>
	
	<div id="main" class="Conteiner" onclick="sbm.hideMusicSelector();">
		<header>
			<div id="header" class="Conteiner">
				<div id="inputHeader" class="Conteiner headerElement">
					<div id="homeButton" class="inputElement"></div>
					<input type="text" onkeyup="sbm.change(this)" id="searchBar" class="inputElement"
			 		placeholder="Escribe una canción, artista o álbum para buscar en la biblioteca.">
					<input type="button" id="download" class="inputElement" onclick="dm.showDownloadList();" value="Download" >
				</div>
				
				<div id="sessionButtons" class="Conteiner headerElement">
					<input type="button" id="login" class="sessionButtonsElement" value="Log In" >
			 		<input type="button" id="signin" class="sessionButtonsElement" value="Sign In" >
				</div>
			 		
			</div>
		</header>
		
		<div id="musicView" class="Conteiner">
			<div id="musicInfo" class="Conteiner musicViewElement">
				<div id="albumImage" class="musicInfoElement">
					<img id="albumImage">
				</div>
				<div id="lyrics1" class="musicInfoElement">ly1</div>
				<div id="lyrics2" class="musicInfoElement">ly2</div>
			</div>
			<div id="musicBar" class="Conteiner musicViewElement">
				<input type="button" id="play" class="musicBarElement" onclick="mp.play();" value="Play">
				<input type="button" id="pause" class="musicBarElement" onclick="mp.pause();" value="Pause">
			</div>
			<div id="songName" class="musicViewElement"></div>
		</div>
		
		<div id="musicList" class="Conteiner">
			<div id="artists" class="musicListElement"></div>
			<div id="albums" class="musicListElement"></div>		
		</div>
	</div>
	
	<div id=overlayLogin class="Conteiner overlay">
		<div id="loginPopup" class="Conteiner overlayLoginElement">
			<h3 id="loginHeader" class="loginPopupElement">Inicia Sesión</h3>
			
			<div id="inputLoginPopup" class="Conteiner loginPopupElement">
				<input type="text" id="loginName" class="inputLoginPopupElement" placeholder="Nombre de usuario.">
				<input type="text" id="loginPassword" class="inputLoginPopupElement" placeholder="Contraseña.">
			</div>
			
			<div id="errorLoginPopup" class="loginPopupElement">El usuario o contraseña es incorrecto.</div>
			
			<div id="buttonsLoginPopup" class="Conteiner loginPopupElement">
				<input type="button"  id="cancelLogin" class="loginPopupElement" value="Cancelar">
				<input type="button"  id="aceptLogin" class="loginPopupElement" value="Aceptar">
			</div>
		</div>
	</div>	
	
	<div id=overlayDownload class="Conteiner overlay">
		<div id=downloadPopup class="Conteiner overlayDownloadElement">
			<div id="downloadHeader" class="downloadPopupElement">Lista de descarga.</div>
			
			<div id="downloadList" class="downloadPopupElement"></div>
			
			<div id="downloadPopupButtons" class="Conteiner downloadPopupElement">
				<a id="downloadLink" download></a>
				<input type="button" id="downloadSongs" class="downloadButtonsElement" onclick="dm.startDownload();" value="Download">
				<input type="button" id="closeDownload" class="downloadButtonsElement" onclick="dm.hideDownloadList();" value="Cerrar">
			</div>
			
		</div>
	</div>

</body>
</html>