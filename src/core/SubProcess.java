package core;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Abstracción de un subproceso que se ejecuta en el sistema operativo.
 * */
public class SubProcess {
	/** Comandos a ejecutarse en la consola */
	private List<String> commands = new ArrayList<String>();
	
	/** Objetos de subproceso propio de java */
	private ProcessBuilder builder;
	
	/** Abstracción que permite encapsular características propias de un proceso */
	private Process process;
	
	/** Resultado de la operación */
	private String result;
	
	/** Código de salida del sub proceso */
	private int exitValue;

	public SubProcess(String[] args) {
		for(String arg : args) {
			commands.add(arg);
		}
	}
	
	public SubProcess(List<String> args) {
		this.commands = args;
	}
	
	/**
	 * @return the exitValue 
	 */
	public int getExitValue() {
		return exitValue;
	}
	
	/**
	 * @return the commands
	 */
	public List<String> getCommands() {
		return commands;
	}

	/**
	 * @param commands the commands to set
	 */
	public void setCommands(List<String> commands) {
		this.commands = commands;
	}

	/**
	 * @return the result
	 */
	public String getResult() {
		return result;
	}
	
	/**
	 * @param commands Comandos a ejecutar.
	 * */
	public void setCommands(String[] commands) {
		this.commands.clear();
		for(String arg : commands) {
			this.commands.add(arg);
		}
	}

	/** Ejecuta el subproceso
	 * @return -1 si el subproceso no se ejecuto, retorna un valor distinto
	 * a -1 si el subproceso se ejecuto pero no garantiza que esa ejecución
	 * fue exitosa. Retorna el código de salida de subproceso.
	 * 
	 *  */
	public int start() {
		this.result = null;
		this.exitValue = -2000; 
		builder = new ProcessBuilder(commands);
		this.result = "";
		try {
			process = builder.start();
			this.exitValue = process.waitFor();
			BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream(), "UTF-8"));
			this.result = br.lines().collect(Collectors.joining("\n"));
			br.close();
			return this.exitValue;
			
		} catch (IOException e) {
			this.exitValue = -1;
			return -1;
		} catch (InterruptedException e) {
			this.exitValue = -1;
			return -1;
		}
	}
	
	public static void main(String[] args) {
		SubProcess sp = new SubProcess(new String[] {"ls","-l"});
		sp.start();
		System.out.println(sp.getResult());
	}
}
