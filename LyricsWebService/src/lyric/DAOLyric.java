package lyric;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.stream.Collectors;

/**
 * Objeto encargado de obtener las letras de canciones
 * */
public class DAOLyric{
	
	/** key que se usa para reemplazar el espacio del artista*/
	private String artist = "#ARTIST#";
	
	/** key usada para remplazar el espacio para el nombre de la canción*/
	private String songName = "#SONG-NAME#";
	
	/** Usado para almacenar la respuesta de la página web*/
	private String webResponse = "";
	
	private String APIKey = "&apikey=30f122f4fe3ac6c0811e974e0352a676";

	
	/**
	 * Obtiene la letra de la canción y la devuelve en formato HTML
	 * */
	public String getStaticLyric(String songName, String artistName) {
		String url = "http://www.songlyrics.com/#ARTIST#/#SONG-NAME#-lyrics/";
		try {
			URL HTTPurl = new URL(
					url.replaceAll(this.artist,artistName
							).replaceAll(this.songName,songName
							).replaceAll("\\s", "-")
					);
			URLConnection conection = HTTPurl.openConnection();

		    conection.addRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");

		    conection.connect();

			
		    HTTPurl.openConnection();

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
		System.out.println(5);

		return response.replaceAll(
		"([\\s\\S]+(<p id=\"songLyricsDiv\"  class=\"songLyricsV14 iComment-text\">))|((<br \\/><\\/p>)[\\s\\S]+)",
				"");
	}
	
	
	/**
	 * Hace una petición a una API y retorna información de la canción,
	 * incluyendo la letra, esta en formato JSON
	 * */
	public String getAPILyric(String songName, String artistName) {
		String url = "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?q_track=#SONG-NAME#&q_artist=#ARTIST#";
		try {
			URL HTTPurl = new URL(String.format("%s%s",
					url.replaceAll(this.artist, artistName)
					.replaceAll(this.songName, songName)
					.replaceAll("\\s", "%20")
					,this.APIKey
					));
			
			HttpURLConnection conection = (HttpURLConnection) HTTPurl.openConnection();
			conection.setRequestMethod("GET");						
		    conection.connect();
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conection.getInputStream() , "UTF-8"));
			return br.lines().collect(Collectors.joining(""));
			
			
		} catch (MalformedURLException e) {
			return "Bad request";

		} catch (IOException e) {
			return "Bad responce";
		}
	}
	
}	
