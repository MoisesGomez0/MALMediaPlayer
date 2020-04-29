<%@page import="core.DTOResponse"%>
<%@page import="core.SessionManager"%>
<%@page import="core.UserStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    /**
    	Controlador encargado de hacer el login para el usuario.
    	Este necesita dos parametros.
    		name: Corresponde al nombre del usuario.
    		password: Contraseña del usuario.
    */
    
    SessionManager sm = new SessionManager();
    UserStatus re = sm.create(session, request);
    
    switch (re){
    case Logged:
    	//Respuesta cuando el usaurio inicio sesión correctamente.
    	out.print(new DTOResponse(true,"\"success login\"").toString());
    	break;
    
    case WrongPass:
    	/*Respuesta cuando existe un usuario con el nombre dado, pero
    		no corresponde con la contraseña.
    	*/
    	out.print(new DTOResponse(false,"\"Wrong pass\"").toString());
    	break;
    	
    case NoRegistered:
    	/*
    	Cuando no existe un usuario con el nombre de se escribió.
    	*/
    	out.print(new DTOResponse(false,"\"No registered\"").toString());
    	break;	
    	
    default:
    	/*
    		Algo raro pasó XDXD
    	*/
    	out.print(new DTOResponse(false,"\"error\"").toString());
    }
    
    
    %>