package cineforum.model;

public class DatiEstrazioneSuggerimenti {
	private String username;
	private int Cluster;
	private int numeroEstrazione;
	
	public DatiEstrazioneSuggerimenti() {
		
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getCluster() {
		return Cluster;
	}

	public void setCluster(int cluster) {
		Cluster = cluster;
	}

	public int getNumeroEstrazione() {
		return numeroEstrazione;
	}

	public void setNumeroEstrazione(int numeroEstrazione) {
		this.numeroEstrazione = numeroEstrazione;
	}
	
	
}
