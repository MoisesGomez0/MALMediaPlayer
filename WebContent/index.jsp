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
	
</script>

</head>
<body onload="mlm.albumsData(); mlm.artistsData();">
	
	<div id="musicSelector"></div>
	
	<div id="main" class="Conteiner" onclick="sbm.hideMusicSelector();">
		<header>
			<div id="header" class="Conteiner">
				<div id="inputHeader" class="Conteiner headerElement">
					<div id="homeButton" class="inputElement">
						
					</div>
					<input type="text" onkeyup="sbm.change(this)" id="searchBar" class="inputElement"
			 		placeholder="Escribe una canción, artista o álbum para buscar en la biblioteca.">
					<input type="button" id="download" class="inputElement" value="Download" >
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
				<input type="button" id="play" class="musicBarElement" value="Play">
				<input type="button" id="stop" class="musicBarElement" value="Stop">
			</div>
			<div id="songName" class="musicViewElement">No hay tal cosa_Oceano_No niegues su existencia</div>
		</div>
		
		<div id="musicList" class="Conteiner">
			<div id="artists" class="musicListElement"></div>
			<div id="albums" class="musicListElement"></div>		
		</div>
	</div>
	
	<div class="Conteiner overlay">
		<div id="loginPopup" class="Conteiner overlayElement">
			<h3 id="loghinHeader" class="loginPopupElement">Inicia Sesión</h3>
			
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

</body>
</html>