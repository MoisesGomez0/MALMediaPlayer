<%@page import="core.DAOLibrary"%>
<%@page import="core.User"%>
<%@page import="core.DTOResponse"%>
<%@page import="core.SessionManager"%>
<%@page import="core.SubProcess"%>
<%@page import="core.UserStatus" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    /**
    	Responde el nombre de un archivo .zip el cual contiene en su interior
    	todas las canciones que fueron solicitadas para ser descargadas.
    	
    	Toma las canciones desde la session.
    
    */
    
    SessionManager sm = new SessionManager();
    UserStatus userStatus = sm.validate(session);
    
   	//Validamos que solo pueda ser comsumido atraves de el index.
    if (userStatus != UserStatus.Logged){
    	out.print(new DTOResponse(false,String.format("\"%s\"",userStatus)));
    	System.out.println("User no Logged");
    }else{
    	SubProcess delete = new SubProcess(new String[]{
    			"sh",
    			"Model/run.sh",
    			"-D",
    			String.format("%s/ROOT/",System.getProperty("wtp.deploy"))
    			
    	});
    	delete.start();

    	User user = (User) session.getAttribute("user");
    	StringBuilder result = new StringBuilder("");
    	DAOLibrary dl = new DAOLibrary();
    	
    	for(String file: user.getDownloadList()){
    		result.append(dl.getPath(file)+"@");
    		System.out.println("hola");
    		System.out.println(file);
    	}
    	
    	System.out.println(result.toString());
    	
    	
    	SubProcess compress = new SubProcess(new String[]{
    			"python3",
    			"Model/Compressor.py",
		    	result.toString()
    	});
    	compress.start();
    	
    	String fileCompressed = compress.getResult();
    	
    	String deployPath = String.format("%s/ROOT/",System.getProperty("wtp.deploy"));
    	SubProcess move = new SubProcess(new String[] {
    			"mv",
    			fileCompressed,
    			deployPath
    	});
    	
    	if(move.start() == 0){
    		out.print(new DTOResponse(true,String.format("\"http://localhost:8080/%s\"",fileCompressed)));
    	}
    }
    
    
    
    %>