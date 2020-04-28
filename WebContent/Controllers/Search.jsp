<%@page import="core.DTOResponse"%>
<%@page import="core.DAOLibrary"%>
<%@page import="core.UserStatus"%>
<%@page import="core.SessionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
 	
    /**
		Controlador encargado de la búsqueda, este responde un 
		String que representa un JSON conteniendo la data que corresponde
		a la respuesta del modelo.
		Necesita el parámetro search
    */
    
    
    if(request.getParameter("search") == null){
    	out.print(new DTOResponse(false,"\"No parameter to search\"").toString());
    }else{
    	
    	DAOLibrary dl = new DAOLibrary();
    	
    	out.print(
    		new DTOResponse(true,
	    		dl.search(
					request.getParameter("search").toString().trim()
	    			)
    		)
    	);
    }
  
%>