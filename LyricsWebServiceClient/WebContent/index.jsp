<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="styles/webApp.css">

<script src="scripts/h.js"></script>
<script src="jquery-3.4.1.min.js"></script>

</head>
<body>

	<div id="main" class="Conteiner">
		<div id="center" class="Conteiner mainElement">
		
			<div id="header" class="centerElement">Lyrics</div>
			
			<input id="songName" class="centerElement" type="text" value="Song">
			<input id="artistName" class="centerElement" type="text" value="artist">
			
			<div id="lyrics" class="centerElement">
				<div id="lyrics1" class="lyricsElement"></div>
				<div id="lyrics2" class="lyricsElement"></div>
			</div>
			
			<input id="search" class="centerElement" onclick="h();" type="button" value="Buscar">
			
		</div>
	</div>

</body>
</html>