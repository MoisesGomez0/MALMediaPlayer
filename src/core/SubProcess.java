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

	public SubProcess(String[] args) {
		for(String arg : args) {
			commands.add(arg);
		}
	}
	
	public SubProcess(List<String> args) {
		this.commands = args;
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

	/** Ejecuta el subproceso
	 * @return 500 si el subproceso no se ejecuto, 
	 * 
	 *  */
	public int start() {
		builder = new ProcessBuilder(commands);
		try {
			process = builder.start();
			process.waitFor();
			BufferedReader br = new BufferedReader(new InputStreamReader(process.getInputStream(), "UTF-8"));
			this.result = br.lines().collect(Collectors.joining("\n"));
			br.close();
			return process.exitValue();
			
		} catch (IOException e) {
			return 500;
		} catch (InterruptedException e) {
			return 500;
		}
	}
}
