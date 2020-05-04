package core;

/*
 * url = "https://canarado-lyrics.p.rapidapi.com/lyrics/40 y 20 jose jose"

headers = {
    'x-rapidapi-host': "canarado-lyrics.p.rapidapi.com",
    'x-rapidapi-key': "a15f1160a8msh188ccf9361b9a47p18d92ajsn26031d598a4b"
    }

response = requests.request("GET", url, headers=headers)

print(response.text)
 * 
 * */

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.stream.Collectors;

/** Accesa a una api para obtener la letra de una canción */
public class DAOAPILirycs{
	
	/** Objeto que abtrae caracteristicas de una canción */
	private Song song;
	
	/** URL sin datos específicos */
	private String url = "https://api.musixmatch.com/ws/1.1/matcher.lyrics.get?q_track=#SONG-NAME#&q_artist=#ARTIST#";
	
	/** key que se usa para reemplazar el espacio del artista*/
	private String artist = "#ARTIST#";
	
	/** key usada para remplazar el espacio para el nombre de la canción*/
	private String songName = "#SONG-NAME#";
	
	private String APIKey = "&apikey=30f122f4fe3ac6c0811e974e0352a676";
	
	public DAOAPILirycs(Song song) {
		this.song = song;
	}
	
	
	/**
	 * Hace una petición a una API y retorna información de la canción,
	 * incluyendo la letra
	 * */
	public String getLyric() {
		try {
			URL url = new URL(String.format("%s%s",
					this.url.replaceAll(this.artist, this.song.getArtist())
					.replaceAll(this.songName, this.song.getName())
					.replaceAll("\\s", "%20")
					,this.APIKey
					));
			
			HttpURLConnection conection = (HttpURLConnection) url.openConnection();
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
	
	public static void main(String[] args) {
	
		new DAOAPILirycs(new Song("my way","album","frank sinatra")).getLyric();
	}
	
}
