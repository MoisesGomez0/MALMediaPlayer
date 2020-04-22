<%@page import="core.SessionManager"%>
<%@page import="core.UserStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    SessionManager sm = new SessionManager();
    UserStatus re = sm.create(session, request);
    
    switch (re){
    case Logged:
    	out.print("{\"status\":true,\"message\":\"success login\"}");
    	break;
    
    case WrongPass:
    	out.print("{\"status\":false,\"message\":\"Wrong pass\"}");
    	break;
    	
    case NoRegistered:
    	out.print("{\"status\":false,\"message\":\"No Registred\"}");
    	break;	
    	
    default:
    	out.print("{\"status\":false,\"message\":\"error\"}");
    }
    
    
    %>