<%@page import="core.DTOResponse"%>
<%@page import="core.SessionManager"%>
<%@page import="core.UserStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    SessionManager sm = new SessionManager();
    UserStatus re = sm.create(session, request);
    
    switch (re){
    case Logged:
    	out.print(new DTOResponse(true,"\"success login\"").toString());
    	break;
    
    case WrongPass:
    	out.print(new DTOResponse(false,"\"Wrong pass\"").toString());
    	break;
    	
    case NoRegistered:
    	out.print(new DTOResponse(false,"\"No registered\"").toString());
    	break;	
    	
    default:
    	out.print(new DTOResponse(false,"\"error\"").toString());
    }
    
    
    %>