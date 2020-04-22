package core;

public enum UserStatus {
	/** Usuario ya registrado */
	AlreadyRegistered,
	
	/** Registro de usuario completado satisfactoriamente */
	SuccessRegistered,
	
	/**Un error ha ocurrido*/
	error,
	
	/** Usuario no registrado */
	NoRegistered,
	
	/** Usuario con sesión iniciada */
	Logged,
	
	/** Usuario con sesión no iniciada */
	NoLogged,
	
	/** Contraseña incorrecta */
	WrongPass
	;
	
}
