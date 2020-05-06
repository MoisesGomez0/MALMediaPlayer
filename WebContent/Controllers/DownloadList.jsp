<%@page import="core.User"%>
<%@page import="core.DTOResponse"%>
<%@page import="core.UserStatus"%>
<%@page import="core.SessionManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    /**
    	Administra la lista de canciones seleccionadas para descargar
    	Parametros action = acción a realizar, posibles valores: 
		   	add -> Añade una canción a la lista, necesita:
		   		name = Nombre de archivo de canción a agregar.
		   		
		   	del -> Elimina una canción de la lista, necesita:
		   		name = Nombre de archivo a sacar de la lista.
		   		
		   	clear -> Elimina toda la lista.
    */
    
    SessionManager sm = new SessionManager();
    
    UserStatus status = sm.validate(session);
    
    if(status != UserStatus.Logged){
    	out.print(new DTOResponse(false,String.format("\"%s\"",status)));
    	
    }else if(request.getParameter("action") != null){
    	User user = (User) session.getAttribute("user");
    	
    	String action = request.getParameter("action").toString().trim();
    	
    	if((action == "add" || action == "del") &&
    			request.getParameter("name") != null){
    		
	    	String name = request.getParameter("name").toString().trim();
	    		
	    	switch(action){
	    	case "add":
	    		user.downloadList.add(name);
	    		out.print(new DTOResponse(true,"\"Added\""));
	    		break;
	    	case "del":
	    		for(int i=0; i < user.downloadList.size(); i++ ){
	    			if( user.downloadList.get(i).equals(name) ){
	    				user.downloadList.remove(i);
	    	    		out.print(new DTOResponse(true,"\"Deleted\""));
	    			}
	    		}    		
	    	}
    	}else if(action == "clear"){
			user.downloadList.clear();
    	
    	}else{
    		out.print(new DTOResponse(false,"\"No avaiable parameter\""));
    	}
    	
    }else{
		out.print(new DTOResponse(false,"\"No parameter\""));

    }
    
    
    %>