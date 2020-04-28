package core;

/** Objeto encargado al acceso a las canciones que existan en el servidor */
public class DAOLibrary {
	
	/**
	 * Usado para la busqueda de canciones.
	 * @param param Parámetro de la busqueda.
	 * @return Un String que representa un JSON
	 * */
	public String search(String param) {
		
		SubProcess sp = new SubProcess(new String[] {"sh","run.sh","-f",param});
		return this.response(sp);
		
	}
	
	/**
	 * Encargado de ejecutar un sub proceso obtener el resultado de este y 
	 * escribir un String que represente un JSON con el estado y resultado del
	 * sub proceso
	 * */
	private String response(SubProcess subProcess) {
		
		subProcess.start();
		if(subProcess.getExitValue() == 0) {
			return new DTOResponse(true, subProcess.getResult()).toString();
		}
		
		return new DTOResponse(false,"\"External Component error\"").toString();
	}
	
	/**
	 * Devuelve el nombres de todas las canciones existentes.
	 * */
	public String getAllSongs() {
		SubProcess sp = new SubProcess(new String[] {"sh","run.sh","-s"});
		return this.response(sp);
		
	}
	
	/**
	 * Retorna el nombre de todos los albums.
	 * */
	public String getAllAlbums() {
		SubProcess sp = new SubProcess(new String[] {"sh","run.sh","-a"});
		return this.response(sp);
		
	}
	
	/**
	 * Retorna el nombre de todos los artistas de los cuales se tiene
	 * guardadas canciones.
	 * */
	public String getAllArtists() {
		SubProcess sp = new SubProcess(new String[] {"sh","run.sh","-A"});
		return this.response(sp);
	}
	
	/*
	 * Pruebas con la clase.
	 * */
	
	public static void main(String[] args) {
		System.out.println(new DAOLibrary().search("6ttyt"));
		System.out.println(new DAOLibrary().search("hola"));
		System.out.println( new DAOLibrary().getAllSongs());
		System.out.println(new DAOLibrary().getAllAlbums());
		System.out.println(new DAOLibrary().getAllArtists());
	}
	
}
