<%@page import="core.DTOResponse"%>
<%@page import="core.Song"%>
<%@page import="core.DAOAPILyrics"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    /**Controlador que comsume una API y retona su respuesta a la vista.*/
    
    if(request.getParameter("songName") != null &&
    	request.getParameter("albumName") != null &&
    	request.getParameter("artist") != null
    		){
    	
   	out.print(
   			new DAOAPILyrics(
   					new Song(
   						request.getParameter("songName").toString().trim(),
   						request.getParameter("albumName").toString().trim(),
   						request.getParameter("artist").toString().trim()
   							)
   					).getLyric()
   			);
    	
    }else{
    	out.print(
    			new DTOResponse(false,"No parameter avaiable").toString()
    			);
    }
    	
    
    
    %>