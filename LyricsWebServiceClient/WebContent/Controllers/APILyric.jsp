<%@page import="lyric.DAOLyricProxy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    if(request.getParameter("songName") != null &&
    	request.getParameter("artistName") != null
    		){
    	out.print(
    			new 
    			DAOLyricProxy().getAPILyric(
    					request.getParameter("songName").toString().trim(),
    					request.getParameter("artistName").toString().trim()
    					)
    			);
    }else{
    	out.print("{\"status\":false,\"message\":\"No parameter avaible\"}");
    }
    
    
    %>