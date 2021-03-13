package cineforum.fia;

import java.util.ArrayList;

import cineforum.model.Film;
import cineforum.model.FilmDAO;
import cineforum.model.ListaDAO;
import weka.clusterers.SimpleKMeans;
import weka.core.Instances;
import weka.core.ManhattanDistance;
import weka.experiment.InstanceQuery;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.NumericToNominal;
import weka.filters.unsupervised.attribute.Remove;

public class KMeansExecutor {
	//Valori calcolati nella classe KMeansEvaluator
	public static final int NUM_CLUSTER = 39;
	public static final int SEED = 199;
	
	//intero dataset
	private static Instances data;
	
	//dataset senza CodiceFilm e Studio
	private static Instances dataClusterer;
	
	private static int[] assignments;
	
	private static SimpleKMeans cl;
	
	static {
		InstanceQuery query;
		
		try {
			//recupero il dataset dal database
			query = new InstanceQuery();
			query.setDatabaseURL("jdbc:mysql://localhost:3306/cineforum?serverTimezone=UTC");
			query.setUsername("cineadmin");
			query.setPassword("Cine.123");
			query.setQuery("select f.CodiceFilm, f.Genere, f.Classificazione, f.Studio, f.Durata from film AS f");
			data =  query.retrieveInstances();
			
			int[] attributes = new int[2];
			attributes[0] = 0; //CodiceFilm
			attributes[1] = 4; //Durata
			
			Remove remove = new Remove();
			remove.setAttributeIndicesArray(attributes);
			remove.setInputFormat(data);
			dataClusterer = Filter.useFilter(data, remove);

			ManhattanDistance df = new ManhattanDistance();
			df.setAttributeIndices("first-last");
			cl = new SimpleKMeans();
			cl.setSeed(SEED); 
			cl.setNumClusters(NUM_CLUSTER);
			cl.setPreserveInstancesOrder(true); // per rendere coerente getAssignments()
			cl.setDistanceFunction(df);
			cl.buildClusterer(dataClusterer);
			assignments = cl.getAssignments();

			//Trasformo CodiceFilm in attributo Nominal poich� Weka non fornisce metodi per recuperare valori numerici
			NumericToNominal transform = new NumericToNominal();
			transform.setAttributeIndices("1");
			transform.setInputFormat(data);
			data = Filter.useFilter(data, transform);
			
		} catch (Exception e) {
			e.printStackTrace();
		}


	}
	
	
	public static ArrayList<Film> getFilmFromCluster(int numCluster, String username){
		ArrayList<Film> cluster = new ArrayList<Film>();
		FilmDAO filmDao = new FilmDAO();
		Film film = null;
		
		int codiceFilm = -1;
		
		for(int row = 0; row < data.numInstances(); row++) {
			if(assignments[row] == numCluster) {
				codiceFilm = Integer.parseInt(data.attribute(0).value(row));
			
				if(!checkFilmLista(codiceFilm, username)) { //verifico che il film non sia nella lista dell'utente
					film = filmDao.retrieveByKey(codiceFilm);
					cluster.add(film);
				}
			}
		} //fine ciclo
		
		return cluster;
	}
	
	public static int getNumClusterFilm(int codiceFilm) {
		/*
		 * Dato che assignments contiene in ordine, per ogni campo, il numero di cluster associato ad ogni riga del dataset
		 * per trovare a quale cluster appartiene il film con codice specificato dal parametro codiceFilm
		 * e dato che il dataset è ordinato in base al codice dei film, possiamo definire la seguente equivalenza: 
		 * numero riga del film con codice pari a codiceFilm = codiceFilm - 1
		 */
		return assignments[codiceFilm - 1]; 
	}
	
	/**
	 * Verifica se un film è già nella lista di un utente
	 * @param codiceFilm codice del film 
	 * @param username userma dell'utente
	 * @return true se il film è nella lista dell'utente, altrimenti false
	 */
	private static boolean checkFilmLista(int codiceFilm, String username) {
		ListaDAO listaOp = new ListaDAO();
		
		if(listaOp.retrieveByKey(codiceFilm, username) != null)
			return true;
		else
			return false;
	}
	
}
