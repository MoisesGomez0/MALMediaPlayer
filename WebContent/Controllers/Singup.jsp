<%@page import="core.DAOUser"%>
<%@page import="core.SessionManager"%>
<%@page import="core.UserStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    DAOUser dao = new DAOUser();
    SessionManager sm = new SessionManager();
    
    String result = "{\"status\":#statusResult#,\"message\":#messageResult#}";
    String statusResult = "#statusResult#";
    String messageResult = "#messageResult#";
    
    if(
    	request.getParameter("name") != null &&
    	request.getParameter("password") != null
    ){
    	
		String name = request.getParameter("name").toString().strip();
	    String password = request.getParameter("password").toString().strip();
	    
	    int daoResponse = dao.register(name, password);
	    
	    switch(daoResponse){
	    case 0:
	    	out.print(
   				result.replaceAll(statusResult, "false")
   				.replaceAll(messageResult,"Already exist")
	    	);
	    	break;
	    case 1:
	    	
	    	if(sm.create(session, request) == UserStatus.Logged){
		    	out.print(
	      			result.replaceAll(statusResult, "true")
	       			.replaceAll(messageResult,"registred and logged")
	   	    	);
	    	}else{
				out.print(
					result.replaceAll(statusResult, "true")
					.replaceAll(messageResult,"Registred but no logged")
				);
	    	}
	    	break;
	    default:
			out.print(
					result.replaceAll(statusResult, "false")
					.replaceAll(messageResult,"error")
				);
	    }
    }else{
    	
    }
%>