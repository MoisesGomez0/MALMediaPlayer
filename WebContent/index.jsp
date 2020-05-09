<%@page import="core.SessionManager"%>
<%@page import="core.UserStatus"%>
<%@page import="java.util.ArrayList"%>
<%@page import="core.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

SessionManager sm = new SessionManager();
if(sm.validate(session) != UserStatus.Logged){
User user = new User("Admin","Root");
session.setAttribute("user", user);
	
}

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MALmediaPlayer</title>

<link rel="stylesheet" type="text/css" href="styles/index.css">

<script src="jquery-3.4.1.min.js"></script>
<script src="scripts/scripts.js"></script>

<script>

	var sbm = new SearchBarManager();
	var mlm = new MusicListManager();
	var mp = new MusicPlayer();
	var vm = new ViewManager();
	var dm = new DownloadManager();
	var mm = new ModelManager();
	
</script>

</head>
<body onload="mlm.albumsData(); mlm.artistsData(); dm.loadDownloadList();">
	
	<div id="musicSelector"></div>
	
	<div id="main" class="Conteiner" onclick="sbm.hideMusicSelector();">
		<header>
			<div id="header" class="Conteiner">
				<div id="inputHeader" class="Conteiner headerElement">
					<div id="homeButton" class="inputElement" onclick="vm.homeAction();"></div>
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
			<div id="mainArt" class="Conteiner musicViewElement">
				<div id="aboutButton" class="mainArtElement"><label id="showAbout" onclick="mm.show();">About</label></div>
				<div id="artConteiner" class="Conteiner mainArtElement">
					<div id="art"></div>
				</div>
			</div>
			
			<div id="mainInfo" class="Conteiner musicViewElement">
				
				<div id="infoButtons" class="Conteiner mainInfoElement">
					<div id="closeInfo" class="infoButtonsElement"><label id="closeInfo" onclick="vm.closeInfo();">x</label></div>
				</div>
				
				<div id="musicInfo" class="Conteiner mainInfoElement">
					<div id="albumImage" class="musicInfoElement">
						<img id="albumImage">
					</div>
					<div id="lyrics1" class="musicInfoElement">ly1</div>
					<div id="lyrics2" class="musicInfoElement">ly2</div>
				</div>
				
				<div id="songName" class="mainInfoElement"></div>
				
				<div id="musicBar" class="Conteiner mainInfoElement">
					<div id="previousButton" class="musicBarElement ctrlButtons" onclick="mp.previous();"></div>
					<div id="nextButton" class="musicBarElement ctrlButtons" onclick="mp.next();"></div>
					<audio id="audioTag" class="musicBarElement" controls autoplay></audio>
				</div>
			</div>
		</div>
		
		<div id="musicList" class="Conteiner">
			<div id="artists" class="musicListElement"></div>
			<div id="albums" class="musicListElement"></div>		
		</div>
	</div>
	
	<div id="overlayAbout" class="Conteiner overlay">
		<div id="aboutPopup" class="Conteiner overlayAboutElement">
			<div id="aboutHeader" class="aboutPopupElement">Créditos:</div>
			
			<div id="aboutBody" class="Conteiner aboutPopupElement">
				<label class="aboutBodyElement">Ana Hernández</label><br>
				<label class="aboutBodyElement">Moisés Gómez</label><br>
				<label class="aboutBodyElement">Leonardo Mass</label><br>
			</div>
			
			<label class="aboutPopupElement">Clase: Programación Orientada a Objetos.</label><br>
			<label class="aboutPopupElement">Sección: 0800</label><br>
			<label class="aboutPopupElement">Año: 2020</label><br>
			<label class="aboutPopupElement">PAC-I</label><br>
			<label class="aboutPopupElement">Catedrático: José Inestroza.</label><br>
			
			<input type="button" onclick="mm.hide();" value="Close">
		</div>
	</div>
	
	<div id="overlayDownload" class="Conteiner overlay">
		<div id="downloadPopup" class="Conteiner overlayDownloadElement">
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