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
import java.net.URLConnection;
import java.util.stream.Collectors;

/** Accesa a una api para obtener la letra de una canción */
public class DAOAPILirycs extends DAOLiryc{
	
	private String APIHost =  "canarado-lyrics.p.rapidapi.com";
	private String APIKey = "a15f1160a8msh188ccf9361b9a47p18d92ajsn26031d598a4b";
	
	public DAOAPILirycs(Song song) {
		super.song = song;
		super.url = "https://canarado-lyrics.p.rapidapi.com/lyrics/#ARTIST# #SONG-NAME#";
	}
	
	
	public String getLyric() {
		/**
		 * Obtiene la letra de la canción y la devuelve en formato HTML
		 * */
		System.out.println(-1);
		try {
			URL url = new URL(
					"https://canarado-lyrics.p.rapidapi.com/40 y 20 jose jose"
					);
			System.out.println(0);
			HttpURLConnection conection = (HttpURLConnection) url.openConnection();
			System.out.println(1);
			
			conection.setRequestMethod("GET");
			conection.setRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");
		    conection.setRequestProperty("x-rapidapi-host", "canarado-lyrics.p.rapidapi.com");
		    conection.setRequestProperty("x-rapidapi-key", "a15f1160a8msh188ccf9361b9a47p18d92ajsn26031d598a4b");
		    /*
		    conection.addRequestProperty("User-Agent","Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)");
		    conection.addRequestProperty("x-rapidapi-host", "canarado-lyrics.p.rapidapi.com");
		    conection.addRequestProperty("x-rapidapi-key", "a15f1160a8msh188ccf9361b9a47p18d92ajsn26031d598a4b");
		    */
			System.out.println(2);
			
			
			
		    conection.connect();
			System.out.println(3);
			
			System.out.println(conection.getContent());
			
			
			url.openConnection();

			BufferedReader br = new BufferedReader(new InputStreamReader(conection.getInputStream() , "UTF-8"));
			System.out.println(br.lines().collect(Collectors.joining("")));
			System.out.println(4);
			return "return a last";
			
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
			return null;

		} catch (IOException e) {
			e.printStackTrace();
			return null;
		}
	}
	
	
	public static void main(String[] args) {

			  try {

				URL url = new URL("https://canarado-lyrics.p.rapidapi.com/lyrics/my%2520way%2520frank%2520sinatra");
				HttpURLConnection conection = (HttpURLConnection) url.openConnection();
				
				conection.setRequestMethod("GET");
	
				conection.setRequestProperty("x-rapidapi-host", "canarado-lyrics.p.rapidapi.com");
			    conection.setRequestProperty("x-rapidapi-key", "a15f1160a8msh188ccf9361b9a47p18d92ajsn26031d598a4b");
			    
			    conection.connect();
			    
			    System.out.println(conection.getResponseCode());
			    
			    
			    
			    
			    
			    
			    
			    
			    
			    
				if (conection.getResponseCode() != 200) {
					throw new RuntimeException("Failed : HTTP error code : "
							+ conection.getResponseCode());
				}

				BufferedReader br = new BufferedReader(new InputStreamReader(
					(conection.getInputStream())));

				String output;
				System.out.println("Output from Server .... \n");
				while ((output = br.readLine()) != null) {
					System.out.println(output);
				}

				conection.disconnect();

			  } catch (MalformedURLException e) {

				e.printStackTrace();

			  } catch (IOException e) {

				e.printStackTrace();

			  }


	}
	
}
