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

	sbm = new SearchBarManager();
</script>

</head>
<body>
	
	<div id="main" class="Conteiner">
		<header>
			<div id="header" class="Conteiner">
				<div id="menuButton" class="headerElement"></div>
				<input type="text" onkeyup="sbm.change(this)" id="searchBar" class="headerElement"
		 		placeholder="Escribe una canción, artista o álbum para buscar en la biblioteca.">
		 		<div id="login" class="headerElement">Log In</div>
		 		<div id="signin" class="headerElement">Sign In</div>
			</div>
		</header>
		
		<div id="musicView" class="Conteiner">
			<div id="musicInfo" class="Conteiner musicViewElement">
				<div id="albumImage" class="musicInfoElement">img</div>
				<div id="lyrics1" class="musicInfoElement">ly1</div>
				<div id="lyrics2" class="musicInfoElement">ly2</div>
			</div>
			<div id="songName" class="musicViewElement">No hay tal cosa_Oceano_No niegues su existencia</div>
			<div id="musicBar" class="musicViewElement">bar</div>
		</div>
		
		<div id="musicList" class="Conteiner">
			<div id="artists" class="musicListElement">artists</div>
			<div id="albums" class="musicListElement">albums</div>		
		</div>
	</div>	

</body>
</html>