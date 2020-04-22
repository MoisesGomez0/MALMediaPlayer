package core;

/** Objeto encargado al acceso a las canciones que existan en el servidor */
public class DAOSongs {
	
	private String result = "{\"status\":#STATUSRESULT#,\"data\":#DATARESULT#}";
	private String statusResult = "#STATUSRESULT#";
	private String dataResult = "#DATARESULT#";
	
	/**
	 * Usado para la busqueda de canciones.
	 * @param param Parámetro de la busqueda.
	 * @return Un String que representa un JSON
	 * */
	public String search(String param) {
		
		SubProcess sp = new SubProcess(new String[] {"sh","find.sh",param});
		return this.response(sp);
		
	}
	
	private String response(SubProcess subProcess) {
		
		subProcess.start();
		if(subProcess.getExitValue() == 0) {
			return this.result.replaceAll(this.statusResult, "true")
					.replaceAll(this.dataResult, subProcess.getResult());
		}
		
		return this.result.replaceAll(this.statusResult, "false")
				.replaceAll(this.dataResult,"External component error");
	}
	
	
	public String getAllSongs() {
		SubProcess sp = new SubProcess(new String[] {"sh","getSongs.sh"});
		return this.response(sp);
		
	}
	
	public String getAllAlbums() {
		SubProcess sp = new SubProcess(new String[] {"sh","getAlbums.sh"});
		return this.response(sp);
		
	}
	
	public String getAllArtists() {
		SubProcess sp = new SubProcess(new String[] {"sh","getArtists.sh"});
		return this.response(sp);
	}
	
	
	public static void main(String[] args) {
		System.out.println( new DAOSongs().getAllSongs());
		System.out.println(new DAOSongs().getAllAlbums());
		System.out.println(new DAOSongs().getAllArtists());
	}
	
}
