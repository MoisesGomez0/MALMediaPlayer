package core;

/**
 * Encargado de administrar el registro de los usuarios
 * */
public class DAOUser {
	
	public DAOUser() {}
	
	/** 
	 * Valida y Registra un nuevo usuario el sistema.
	 * @param name Nombre de usuario.
	 * @param password Contraseña del usuario.
	 * @return Retorna -1 si existió un error en el subproceso, 
	 * retorna 0 si ya existe ese identificador de usuario, 
	 * retorna 1 si el usuario fue registrado correctamente, cualquier
	 * otro número de retorno corresponde a los comandos del archivo por lotes
	 * o comandos a ejecutar.
	 *  */
	public int register(String name, String password) {
		int isRegistredExitCode = this.isRegistred(name);
		
		if(isRegistredExitCode == 1) {
			SubProcess subProcess = new SubProcess(
				new String[] {
					"sh",
					"Model/run.sh",
					"-r",
					String.format("%s,%s", name, password)
				}
			);
			subProcess.start();
		}
		return isRegistredExitCode;
	}
	
	/** Determina si un usuario está ya registrado en el sistema.
	 *  @param name El nombre de usuario a validar.
	 *  @return -1 si no se pudo determinar la existencia del usuario.
	 * 	0 si ya existe un usuario con ese nombre.
	 * 	1 si el usuario no está registrado.
	 *  */
	public int isRegistred(String name){
		SubProcess subProcess = new SubProcess(
			new String[] {
				"sh",
				"Model/run.sh",
				"-g",
				String.format("^%s,",name)
				}
			);
		subProcess.start();
		if(subProcess.getExitValue() != -1) {
			return subProcess.getExitValue();
		}else {
			System.err.println("El proceso no se pudo ejecutar");
			return -1;
		}
	}
	
	
	/**
	 * Devuelve la contraseña de un usuario, si no está registrado retorna 
	 * #NonRegistred#
	 * @param name Nombre de usuario.
	 * @return password o #NonRegistred#
	 * 
	 * */
	public String getPassword(String name) {
		SubProcess subProcess = new SubProcess(
			new String[] {
				"sh",
				"Model/run.sh",
				"-g",
				String.format("^%s,", name)
			}		
		);
		subProcess.start();
		if(subProcess.getExitValue() == 0) {
			return subProcess.getResult().split(",")[1].trim();
		}else if(subProcess.getExitValue() == 1) {
			return "#NonRegistred#";
		}
		return null;
	}
	
	
}