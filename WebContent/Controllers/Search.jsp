<%@page import="core.DAOSongs"%>
<%@page import="core.UserStatus"%>
<%@page import="core.SessionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
        
    if(request.getParameter("search") != null){
    	out.print("{\"status\":false,\"data\":\"No Parameter to search\"}");
    }else{
    	DAOSongs ds = new DAOSongs();
    	
    	String parameter = request.getParameter("search").toString().strip();
    	
    	switch(parameter){
    		case "getAllSongs":
	    		out.print(ds.getAllSongs());
				break;    			
    		case "getAllAlbums":
    			out.print(ds.getAllAlbums());
    			break;
    		case "getAllArtists":
    			out.print(ds.getAllArtists);
    			break;
    		default:
		    	out.print(ds.search(parameter));
    	
    	}
    	
    	
    }
%>