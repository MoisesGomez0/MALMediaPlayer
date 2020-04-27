<%@page import="core.SubProcess"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    /**
    	Responde el nombre de un archivo .zip el cual contiene en su interior
    	todas las canciones que fueron solicitadas para ser descargadas.
    	
    	Necesita el parametros files el cual debe correponder con la nomenclatura:
    		Nombre_de_archivo1@Nombre_de_archivo2@Nombre_de_archivo3.
    
    */
    
    
    SubProcess sp = new SubProcess(
    		new String[] {
    				"python3",
    				"Compressor.py",
    				request.getParameter("files").toString().trim()
    				}
    		);
    sp.start();
    response.sendRedirect(sp.getResult());
    %>