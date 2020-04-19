package core;

/**
 * Encargado de administrar el registro e ingreso de los usuarios.
 * */
public class UsersManager {
	public UserStatus register(String name, String password) {
		return UserStatus.AlreadyRegistered;
	}
	
	/** Determina si un usuario está ya registrado en el sistema */
	public boolean isRegistred(String name, String password){
		SubProcess subProcess = new SubProcess(new String[] {"sh","existUser.sh",name,Constants.usersFile});
		if(subProcess.start()) {
			System.out.println(subProcess.getResult());
			return true;
		}else {
			System.out.println("Algo salió mul mal");
			return false;
			
		}
	}

	
	public static void main(String[] args){
		UsersManager um = new UsersManager();
		um.isRegistred("pola", "Mundo");
	}
	
}