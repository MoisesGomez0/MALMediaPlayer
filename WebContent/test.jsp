<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" type="text/css" href="styles/test.css">

<script src="jquery-3.4.1.min.js"></script>
<script src="scripts/scripts.js"></script>

</head>
<body>
	
	<script>
	
	var fileName = "Low Roar_0_Easy Way Out.mp3";
		
	function ViewManager(){
		this.musicName = "";
		this.albumImagePath = "";
		this.audioPath = "";
		this.lyrics1 = "";
		
		this.setInfo = function(fileName){
			var name = fileName.replace(".mp3","");
			var songName = name.split("_")[2];
			var artistName = name.split("_")[0];
			var albumName = name.split("_")[1];
		
			console.group("request");
			$.post("Controllers/Search.jsp",{"search": fileName},function(data){
				console.group("search");
				data = JSON.parse(data);
				console.log(data);
				console.groupEnd("search");
			});
			
			$.post("Controllers/StaticLyric.jsp",{"songName": songName, "albumName": albumName, "artist": artistName},function(data){
				console.group("lyrics");
				data = JSON.parse(data);
				console.log(data);
				console.groupEnd();
			});
			
			$.post("Controllers/Play.jsp",{"fileName": "Low Roar_0_Easy Way Out.mp3"},function(data){
				console.group("Play");
				data = JSON.parse(data);
				console.log(data);
				
				console.groupEnd();
			});
			
			console.groupEnd("request");
		}
	}
	
	var v = new ViewManager();
	v.setInfo(fileName);	

	
	
	</script>
	
</body>
</html>