<%@page import="core.SubProcess"%>
<%@page import="core.DTOResponse"%>
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
    
   	if(request.getParameter("fileName") == null){
   		out.print(new DTOResponse(false,"\"No parameter fileName.\""));
   	}else{
   		String fileName = request.getParameter("fileName").toString().trim();
   		String albumName = String.format("%s_%s",fileName.split("_")[0],fileName.split("_")[1]);
   		String deployPath = String.format("%s/ROOT/",System.getProperty("wtp.deploy"));
   		String fullFileName = "";
   		String fullAlbumName = "";
   		
   		SubProcess sp = new SubProcess(new String[]{"sh","run.sh","-F",fileName});

   		
   		if(sp.start() == 0){
	   			fullFileName = sp.getResult();
	   			
				sp.setCommands(new String[] {"find", ".", "-type", "f", "(",
						"-name",
						String.format("%s.png",albumName),
						"-o", "-name",
						String.format("%s.jpg",albumName),
						"-o", "-name",
						String.format("%s.jpeg",albumName),
						")"});

	   			if(sp.start() == 0){
	   				fullAlbumName = sp.getResult();
	   			}
	   			
	   			sp.setCommands(new String[] {"cp",
	   					String.format("%s",fullFileName),
	   					String.format("%s",fullAlbumName),
	   					String.format("%s",deployPath)
	   			});
	   			
	   			if(sp.start() == 0){
	   				out.print(
	   						new DTOResponse(true,
	   								String.format(
	   										"{\"songPath\":\"http://localhost:8080/%s\",\"albumPath\":\"http://localhost:8080/%s\"}",
	   										fileName,
	   										albumName
	   										)
	   								)
	   						);
	   			}else{

	   				out.print(
	   						
	   						new DTOResponse(false,"\"No copy files.\"")
	   						);
	   			}
   				
   			}else{
   				out.print(new DTOResponse(false,"\"file not found.\""));
   			}
   		}
    
    
    %>