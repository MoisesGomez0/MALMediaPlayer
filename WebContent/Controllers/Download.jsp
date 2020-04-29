<%@page import="core.DTOResponse"%>
<%@page import="core.SessionManager"%>
<%@page import="core.SubProcess"%>
<%@page import="core.UserStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    /**
    	Responde el nombre de un archivo .zip el cual contiene en su interior
    	todas las canciones que fueron solicitadas para ser descargadas.
    	
    	Necesita el parametros files el cual debe correponder con la nomenclatura:
    		Nombre_de_archivo1@Nombre_de_archivo2@Nombre_de_archivo3.
    
    */
    
    SessionManager sm = new SessionManager();
    if (sm.validate(session) == UserStatus.Logged){
    	out.print(new DTOResponse(false,"\"No Logged\""));
    }else
    	
    if(request.getParameter("files") == null){
    	out.print(new DTOResponse(false,"\"No Parameter\""));
    }else{
    	String[] files = request.getParameter("files").toString().trim().split("@");
    	
    	StringBuilder result = new StringBuilder("");
    	
    	
    	for(String file: files){
	    	SubProcess listFiles = new SubProcess(new String[]{
	    			"sh",
	    			"run.sh",
	    			"-F",
	    			String.format("%s",file)
	    	});
	    	listFiles.start();
	    	result.append(listFiles.getResult()+"@");	
    	}
    	
    	
    	SubProcess compress = new SubProcess(new String[]{
    			"python3",
    			"Compressor.py",
		    	result.toString()
    	});
    	compress.start();
    	
    	out.print(compress.getResult());
    	
    }
    
    
    
    %>