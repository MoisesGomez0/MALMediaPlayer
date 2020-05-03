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
public class Lyric {
	
	/** Objeto que abtrae caracteristicas de una canción */
	private Song song;
	
	/** URL sin datos específicos */
	private String url = "http://www.songlyrics.com/#ARTIST#/#SONG-NAME#-lyrics/";
	
	/** key que se usa para reemplazar el espacio del artista*/
	private String artist = "#ARTIST#";
	
	/** key usada para remplazar el espacio para el nombre de la canción*/
	private String songName = "#SONG-NAME#";
	
	/** Usado para almacenar la respuesta de la página web*/
	private String webResponse = "";
	
	
	public Lyric(Song song) {
		this.song = song;
	}
	
	public String getLyric() {
		/**
		 * Obtiene la letra de la canción y la devuelve en formato HTML
		 * */
		try {
			URL url = new URL(
					this.url.replaceAll(this.artist,this.song.getArtist()
							).replaceAll(this.songName,this.song.getName()
							).replaceAll("\\s", "-")
					);
			System.out.println(0);
			URLConnection conection = url.openConnection();
			System.out.println(1);

		    conection.addRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");
			System.out.println(2);

		    conection.connect();
			System.out.println(3);

			
			url.openConnection();

			BufferedReader br = new BufferedReader(new InputStreamReader(conection.getInputStream() , "UTF-8"));
			this.webResponse = br.lines().collect(Collectors.joining(""));
			System.out.println(4);

			
			return this.cleanWebStaticContent(this.webResponse);
			
		} catch (MalformedURLException e) {
			return new DTOResponse(false, "\"Bad request\"").toString();
		} catch (IOException e) {
			return new DTOResponse(false, "\"Bad responce\"").toString();
		}
	}
	
	private String cleanWebStaticContent(String response) {
		/**
		 * Encargado de limpiar la respuesta de la página web y dejar
		 * solo la letra de la canción en HTML
		 * 
		 * @param response Respuesta de la página web
		 * 
		 * @return Letra de la canción en formato HTML
		 * */
		System.out.println(5);
		
		return response.replaceAll(
				"([\\s\\S]+(<p id=\"songLyricsDiv\"  class=\"songLyricsV14 iComment-text\">))|((<br \\/><\\/p>)[\\s\\S]+)|(\")",
				"");
	}
	
	public static void main(String[] args){
		Lyric l = new Lyric(new Song("My way","hola","Frank Sinatra"));
	    
	    System.out.println(l.getLyric());
	}
}	
