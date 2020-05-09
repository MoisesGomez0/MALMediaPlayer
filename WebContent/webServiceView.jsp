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

<script>
	var lm = new LyricsManager();
</script>

</head>
<body>

	<div id="main" class="Conteiner">
		<div id="center" class="Conteiner mainElement">
		
			<div id="header" class="centerElement">Lyrics</div>
			
			<input id="songName" class="centerElement" type="text" placeholder="Song">
			<input id="artistName" class="centerElement" type="text" placeholder="Artist">
			
			<div id="lyrics" class="Conteiner centerElement">
				<div id="lyrics1" class="lyricsElement"></div>
				<div id="lyrics2" class="lyricsElement"></div>
			</div>
			
			<input id="search" class="centerElement" onclick="lm.searchLyrics();" type="button" value="Buscar">
			
		</div>
	</div>

</body>
</html>