<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="jquery-3.4.1.min.js"></script>
<script src="scripts/scripts.js"></script>

</head>
<body>
	<script>
	var fileName = "Low Roar_0_Easy Way Out.mp3";
	var name = fileName.replace(".mp3","");
	var songName = name.split("_")[2];
	var artistName = name.split("_")[0];
	var albumName = name.split("_")[1];
	
		var lyric = "";
		
		function test(){
			return $.post("Controllers/StaticLyric.jsp",{"songName": songName, "albumName": albumName, "artist": artistName},function(data){
				console.group("lyrics");
				data = JSON.parse(data);
				console.log(data);
				console.groupEnd();
				lyric = data.status;
				console.log(lyric);
			});
		}
		
		test().done(function(){
			console.log("completado.");
		});
		
		console.group("original");
		console.log(lyric);
		console.groupEnd();
	</script>
</body>
</html>