<%@page import="core.DTOResponse"%>
<%@page import="core.Song"%>
<%@page import="core.Lyric"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    /**
    	Controlador encargado de hacer una petición a una página web estática
    	con la letra de la canción que se establescan el los parámetros.
    	Parámetros:
    		songName: Nombre de la canción.
    		albumName: Albún al que pertenece la canción.
    		artist: Artista que interpreta la canción
    */
    
    if(request.getParameter("songName") != null &&
    request.getParameter("albumName") != null &&
    request.getParameter("artist") != null){
	    Lyric l = new Lyric(
	    		new Song(
	    				request.getParameter("songName").toString().trim(),
	    				request.getParameter("albumName").toString().trim(),
	    				request.getParameter("artist").toString().trim()
	    		)
	    );
	    
	    out.print(String.format(
	    		"{\"status\":true,\"message\":\"%s\"}",
	    		l.getLyric().replaceAll("\"", "'")
	    		)
	    	);
    	
    }else{
    	out.print(new DTOResponse(false,"\"Invalid parameter\""));
    }
    
    
    
    %>