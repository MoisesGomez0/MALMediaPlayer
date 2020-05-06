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
    
    if (userStatus != UserStatus.Logged){
    	out.print(new DTOResponse(false,String.format("\"%s\"",userStatus)));
    	
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
    	
    	
    	for(String file: user.downloadList){
	    	SubProcess listFiles = new SubProcess(new String[]{
	    			"sh",
	    			"Model/run.sh",
	    			"-F",
	    			String.format("%s",file)
	    	});
	    	listFiles.start();
	    	result.append(listFiles.getResult()+"@");	
    	}
    	
    	
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