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
    System.out.println("Antes del de que u");
    System.out.println(userStatus);
    if (userStatus != UserStatus.Logged){
    	out.print(new DTOResponse(false,String.format("\"%s\"",userStatus)));
    	System.out.println(1);
    }else{
    	System.out.println(2);
    	SubProcess delete = new SubProcess(new String[]{
    			"sh",
    			"Model/run.sh",
    			"-D",
    			String.format("%s/ROOT/",System.getProperty("wtp.deploy"))
    			
    	});
    	System.out.println(3);
    	delete.start();
    	System.out.println(4);
    	User user = (User) session.getAttribute("user");
    	System.out.println(4.1);
    	System.out.println(user);
    	StringBuilder result = new StringBuilder("");
    	System.out.println(5);
    	System.out.println(user.getDownloadList());
    	
    	for(String file: user.getDownloadList()){
    		System.out.println(6);
	    	SubProcess listFiles = new SubProcess(new String[]{
	    			"sh",
	    			"Model/run.sh",
	    			"-F",
	    			String.format("%s",file)
	    	});
	    	System.out.println(7);
	    	listFiles.start();
	    	result.append(listFiles.getResult()+"@");	
    	}
    	System.out.println(8);
    	
    	SubProcess compress = new SubProcess(new String[]{
    			"python3",
    			"Model/Compressor.py",
		    	result.toString()
    	});
    	System.out.println(9);
    	compress.start();
    	System.out.println(10);
    	String fileCompressed = compress.getResult();
    	String deployPath = String.format("%s/ROOT/",System.getProperty("wtp.deploy"));
    	System.out.println(11);
    	SubProcess move = new SubProcess(new String[] {
    			"mv",
    			fileCompressed,
    			deployPath
    	});
    	System.out.println(12);
    	if(move.start() == 0){
    		out.print(new DTOResponse(true,String.format("\"http://localhost:8080/%s\"",fileCompressed)));
    	}
    	System.out.println(11);
    }
    
    
    
    %>