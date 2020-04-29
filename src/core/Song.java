package core;

/** Clase que representa la abstracción de una canción */
public class Song {
	
	public Song(String name, String album, String artist) {
		this.name = name;
		this.album = album;
		this.artist = artist;
	}
	
	/** Nombre de la canción */
	private String name;
	
	/** Nombre del album */
	private String album;
	
	/** Nombre del artista */
	private String artist;

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @return the album
	 */
	public String getAlbum() {
		return album;
	}

	/**
	 * @return the artist
	 */
	public String getArtist() {
		return artist;
	}


	
	
}
