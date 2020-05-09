package core;

import java.util.ArrayList;

/** Representación de usuario  */
public class User {
	/**Nombre de usuario*/
	private String name;
	
	/**Contraseña de usuario*/
	private String password;
	
	/***/
	private ArrayList<String> downloadList = new ArrayList<>();
	
	public ArrayList<String> getDownloadList() {
		return downloadList;
	}

	public void setDownloadList(ArrayList<String> downloadList) {
		this.downloadList = downloadList;
	}

	public User(String name) {
		this.name = name;
	}
	
	public User(String name, String password, ArrayList<String> downloadList) {
		this.name = name;
		this.password = password;
		this.downloadList = downloadList;
	}
	
	public User(String name, String password) {
		this.name = name;
		this.password = password;
	}
	
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	
	
}
