<%@page import="core.DAOLibrary"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    	    
	/**
	Responde un String que representa un JSON que contiene el nombre de
    todos los artistas, este no requiere parametros
	*/
	
    DAOLibrary dl = new DAOLibrary();
    
    out.print(dl.getAllAlbums());
    
    %>