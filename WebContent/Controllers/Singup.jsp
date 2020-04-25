<%@page import="core.DTOResponse"%>
<%@page import="core.DAOUser"%>
<%@page import="core.SessionManager"%>
<%@page import="core.UserStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    DAOUser dao = new DAOUser();
    SessionManager sm = new SessionManager();
   
    
    if(
    	request.getParameter("name") != null &&
    	request.getParameter("password") != null
    ){
    	
		String name = request.getParameter("name").toString().trim();
	    String password = request.getParameter("password").toString().trim();
	    
	    int daoResponse = dao.register(name, password);
	    
	    switch(daoResponse){
	    case 0:
	    	out.print(
	    			new DTOResponse(false,"Already exist").toString()
	    	);
	    	break;
	    case 1:
	    	
	    	if(sm.create(session, request) == UserStatus.Logged){
		    	out.print(
		    			new DTOResponse(true,"registred and logged").toString()
	   	    	);
	    	}else{
				out.print(
		    			new DTOResponse(true,"Registred but no logged").toString()
				);
	    	}
	    	break;
	    default:
			out.print(
	    			new DTOResponse(false,"error").toString()
				);
	    }
    }else{
    	
    }
%>