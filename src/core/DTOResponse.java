package core;

/**
 * Abstracción de la respueste de los controladores al la vista
 * */
public class DTOResponse {
	
	/** Toda respuesta debe tener un estatus de éxito o fracaso */
	private String status;
	
	/** Toda respuesta debe incluir información adicional al estatus */
	private String data;
	
	/** Platilla usada como respuesta final */
	String result = "{\"status\":#statusResult#,\"message\":#messageResult#}";
	
	/** Texto para ser suplantado como estatus */
    String statusResult = "#statusResult#";
    
    /** Texto para se reemplazaso como mensaje de salida. */
    String messageResult = "#messageResult#";
    
	public DTOResponse(String status, String data) {
		this.status = status;
		this.data = data;
	}
	
	public DTOResponse(boolean status, String data) {
		this.status = Boolean.toString(status);
		this.data = data;
	}

	@Override
	public String toString() {
		return this.result
				.replaceAll(this.statusResult, this.status)
				.replaceAll(this.messageResult,this.data);
	}
	
	
	
}
