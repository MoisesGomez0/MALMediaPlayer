<%@page import="core.SubProcess"%>
<%@page import="core.PlayManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    
    /**
    Controlador encargado de copiar al Localhost Path los archivos necesarios para la reproducción de 
    una canción.
    Parametros:
    	fileName: Nombre del archivo a reproducir.
   	Respuesta:
   		JSON: Texto que representa un json con status de la petición y un arreglo con la url de los archivos
   		copiados al Localhost Path si estos se copiaron correctamente.
    */
    
	SubProcess delete = new SubProcess(new String[]{
			"sh",
			"Model/run.sh",
			"-d",
			String.format("%s/ROOT/",System.getProperty("wtp.deploy"))
		
	});
	delete.start();
	    
    PlayManager pm = new PlayManager(request);
    
    out.print(pm.setToPlay());
    
    
    %>