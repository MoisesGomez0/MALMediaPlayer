<%@page import="core.DTOResponse"%>
<%@page import="core.DAOUser"%>
<%@page import="core.SessionManager"%>
<%@page import="core.UserStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    /**
    Controlador encargado de registrar un nuevo usuario en los datos.
    	parametros:
    		name: nombre del nuevo usaurio.
    		password: contraseña del nuevo usuario.
    */
    
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
	    	/* respuesta cuando el usuario ya existe, y no se registró. */
	    	out.print(
	    			new DTOResponse(false,"Already exist").toString()
	    	);
	    	break;
	    case 1:
	    	
	    	if(sm.create(session, request) == UserStatus.Logged){
	    		/*Respuesta cuando el usuario está registrado correctamente
	    			e iniciado sesión.
	    		*/
		    	out.print(
		    			new DTOResponse(true,"registred and logged").toString()
	   	    	);
	    	}else{
	    		/*El usuario se registró, pero no se pudo iniciar sesión. No creo que
	    		pase pero por si las moscas.
	    		*/
				out.print(
		    			new DTOResponse(true,"Registred but no logged").toString()
				);
	    	}
	    	break;
	    default:
	    	/*Ocurrió algún error.*/
			out.print(
	    			new DTOResponse(false,"error").toString()
				);
	    }
    }else{
    	
    }
%>