package core;

public abstract class DAOLiryc {
	/** Objeto que abtrae caracteristicas de una canción */
	protected Song song;
	
	/** URL sin datos específicos */
	protected String url = "http://www.songlyrics.com/#ARTIST#/#SONG-NAME#-lyrics/";
	
	/** key que se usa para reemplazar el espacio del artista*/
	protected String artist = "#ARTIST#";
	
	/** key usada para remplazar el espacio para el nombre de la canción*/
	protected String songName = "#SONG-NAME#";
	
	/** Usado para almacenar la respuesta de la página web*/
	protected String webResponse = "";
	
	public String getLiryc() {
		return null;
	}
	
	
}
