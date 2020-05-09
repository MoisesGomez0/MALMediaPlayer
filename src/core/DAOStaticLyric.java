package core;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.stream.Collectors;

/**
 * Objeto encargado de obtener las letras de canciones
 * */
public class DAOStaticLyric{
	
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
	
	public DAOStaticLyric(Song song) {
		this.song = song;
	}
	
	/**
	 * Obtiene la letra de la canción y la devuelve en formato HTML
	 * */
	public String getLyric() {
		try {
			URL url = new URL(
					this.url.replaceAll(this.artist,this.song.getArtist()
							).replaceAll(this.songName,this.song.getName()
							).replaceAll("\\s", "-")
					);
			URLConnection conection = url.openConnection();

		    conection.addRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");

		    conection.connect();

			
			url.openConnection();

			BufferedReader br = new BufferedReader(new InputStreamReader(conection.getInputStream() , "UTF-8"));
			this.webResponse = br.lines().collect(Collectors.joining(""));

			
			return this.cleanWebStaticContent(this.webResponse);
			
		} catch (MalformedURLException e) {
			return "Bad request";
		} catch (IOException e) {
			return "Bad responce";
		}
	}
	
	/**
	 * Encargado de limpiar la respuesta de la página web y dejar
	 * solo la letra de la canción en HTML
	 * 
	 * @param response Respuesta de la página web
	 * 
	 * @return Letra de la canción en formato HTML
	 * */
	private String cleanWebStaticContent(String response) {

		return response.replaceAll(
		"([\\s\\S]+(<p id=\"songLyricsDiv\"  class=\"songLyricsV14 iComment-text\">))|((<br \\/><\\/p>)[\\s\\S]+)",
				"");
	}
	
}	
