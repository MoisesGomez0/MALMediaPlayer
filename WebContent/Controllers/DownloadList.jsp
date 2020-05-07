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
    	
    	if((action.equals("add") || action.equals("del")) &&
    			request.getParameter("name") != null){
    		
	    	String name = request.getParameter("name").toString().trim();
	    		
	    	switch(action){
	    	case "add":
	    		user.getDownloadList().add(name);
	    		session.setAttribute("user", user);
	    		out.print(new DTOResponse(true,"\"Added\""));
	    		break;
	    	case "del":
	    		for(int i=0; i < user.getDownloadList().size(); i++ ){
	    			if( user.getDownloadList().get(i).equals(name) ){
	    				user.getDownloadList().remove(i);
	    				session.setAttribute("user", user);
	    	    		out.print(new DTOResponse(true,"\"Deleted\""));
	    			}
	    		}    		
	    	}
    	}else if(action.equals("clear")){
			user.getDownloadList().clear();
			session.setAttribute("user", user);
    	}else if(action.equals("get")){
    		
    		StringBuilder result = new StringBuilder("");
    		for(int i=0; i<user.getDownloadList().size() - 1; i++){
    			result.append(
    					String.format("%s@",
    							user.getDownloadList().get(i)
    							)
    					);
    		}
    		result.append(user.getDownloadList().get(
    				user.getDownloadList().size() - 1
    				)
    			);
    		out.print(new DTOResponse(true, String.format("\"%s\"",result.toString())));
    		
    	} 	
    	else{
    		out.print(new DTOResponse(false,"\"No avaiable parameter\""));
    	}
    	
    }else{
		out.print(new DTOResponse(false,"\"No parameter\""));

    }
    
    
    %>