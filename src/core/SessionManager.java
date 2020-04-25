package core;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Administra la sesión.
 * */
public class SessionManager {

	public SessionManager () {}
	
	/**
	 * Valida el estado de la sesión
	 * @param session Sesión del navegador
	 * @return Estatus que representa el estado del usuario.
	 */
	public UserStatus validate(HttpSession session) {
		if(
		session.getAttribute("user") != null &&
		session.getAttribute("user").getClass().getSimpleName().equals("User")
		){
			DAOUser mum = new DAOUser();
			User user = (User) session.getAttribute("user");
			if(mum.isRegistred(user.getName()) == 0) {
				return UserStatus.Logged;
			}else {
				return UserStatus.NoLogged;
			}
		}
		return UserStatus.error;
	}
	
	
	/** Crea una sesión de usuario
	 * @param session Sesión de usuario.
	 * @param request request.
	 * @return UserStatus value Valor que representa los posibles estados del usuario.
	 */
	public UserStatus create(HttpSession session, HttpServletRequest request) {
		DAOUser mum = new DAOUser();
		if(
		request.getParameter("name") != null && 
		request.getParameter("password") != null
		) {
			
			String name = request.getParameter("name").toString().trim();
			String password = request.getParameter("password").toString().trim();
			
			if(mum.isRegistred(name) == 0) {
				if(mum.getPassword(name).equals(password)) {
					session.setAttribute("user", new User(name));
					return UserStatus.Logged;
				}else {
					return UserStatus.WrongPass;
				}
			}else {
				return UserStatus.NoRegistered;
			}
		}else {
			return UserStatus.error;
		}
		
	}
	
}
