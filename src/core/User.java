package core;

import java.util.List;

/** Representación de usuario  */
public class User {
	/**Nombre de usuario*/
	private String name;
	
	/**Contraseña de usuario*/
	private String password;
	
	/***/
	public List<String> downloadList;
	
	public User(String name) {
		this.name = name;
	}
	
	public User(String name, String password) {
		this.name = name;
		this.password = password;
		this.downloadList = downloadList;
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
