package core;

import javax.servlet.http.HttpServletRequest;

/** Encargado de copiar y administrar los archivos
 * reproducción
 *  */
public class PlayManager {
	String fileName;
	String albumName;
	
	String deployPath;
	
	String fullFileName;
	String fullAlbumName;
	
	String extensionAlbum;
	
	public PlayManager(HttpServletRequest request) {
		fileName = request.getParameter("fileName").toString().trim();
   		albumName = String.format("%s_%s",fileName.split("_")[0],fileName.split("_")[1]);
   		deployPath = String.format("%s/ROOT/",System.getProperty("wtp.deploy"));
	}
	
	/**
	 * Busca el archivo de contenido de audio en la libreria
	 * y lo establece en los atributos de la clase.
	 * Retorna true si lo encontró.
	 * */
	private boolean findFile() {
   		SubProcess sp = new SubProcess(new String[]{"sh","Model/run.sh","-F",fileName});
   		sp.start();
   		this.fullFileName = sp.getResult();
   		return sp.getExitValue() == 0;

	}
	
	/** Busca el archivo de imagen del album y lo establece en los atributos.
	 * Retorna true si lo encontró.
	 *  */
	private boolean findAlbum() {
		SubProcess sp = new SubProcess(new String[] {"find", ".", "-type", "f", "(",
				"-name",
				String.format("%s.png",albumName),
				"-o", "-name",
				String.format("%s.jpg",albumName),
				"-o", "-name",
				String.format("%s.jpeg",albumName),
				")"});
		sp.start();
		
		this.fullAlbumName = sp.getResult();
		
		this.extensionAlbum = fullAlbumName
			.replaceAll(
					String.format("[\\s\\S]+%s",albumName), 
					"");	   				
		this.albumName = String.format("%s%s",albumName,this.extensionAlbum);
		
		return !this.fullAlbumName.equals("");

	}
	
	/**
	 * Copia los archivos encontrados en la ruta del localhost
	 * */
	private boolean copyToDeploy() {
		SubProcess sp = new SubProcess(new String[] {});
		
		if( !this.extensionAlbum.equals("") ){
			sp.setCommands(new String[] {"cp",
					String.format("%s",this.fullFileName),
					String.format("%s",this.fullAlbumName),
					String.format("%s",this.deployPath)
			});
			
			return sp.start() == 0;
			
		}else{
			sp.setCommands(new String[] {"cp",
				String.format("%s",fullFileName),
				String.format("%s",deployPath)
			});
			return sp.start() == 0;
		}
	
	}
	
	/**
	 * Ejecuta la rutina completa de busqueda y copia.
	 * retorna las respuesta correspondientes en cadena con 
	 * nomenclatura JSON.
	 * */
	public String setToPlay() {
		
		if(this.findFile()) {
			
			boolean albumstatus = this.findAlbum();
			
			if(this.copyToDeploy()) {
				if(albumstatus) {
					
					return new DTOResponse(true,
					String.format("{\"songPath\":\"http://localhost:8080/%s\",\"albumPath\":\"http://localhost:8080/%s\"}",
							this.fileName,this.albumName)).toString();
					
				}else {
					
					return new DTOResponse(true,
					String.format("{\"songPath\":\"http://localhost:8080/%s\"}",
							this.fileName)).toString();
					
				}
			}else {
				
				return new DTOResponse(false,"\"No copy files.\"").toString();

			}
			
		}else {
			return new DTOResponse(false,"\"file not found.\"").toString();
		}
		
	}
	
	

}
