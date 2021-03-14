package cineforum.fia;

import java.util.ArrayList;
import java.util.Random;

import cineforum.model.DatiEstrazioneSuggerimenti;
import cineforum.model.DatiEstrazioneSuggerimentiDAO;
import cineforum.model.Film;

/**
 * Classe che si occupa di generare i suggerimenti per un dato utente
 *
 */
public class SuggerisciFilm {

	/**
	 * Produce ArrayList di film da suggerire all'utente
	 * 
	 * @param username Utente a cui si devono suggerire i film
	 * @return ArrayList di film
	 */
	public static ArrayList<Film> getSuggerimenti(String username){
		DatiEstrazioneSuggerimentiDAO datiDAO = new DatiEstrazioneSuggerimentiDAO();
		DatiEstrazioneSuggerimenti estrazioneCorrente = null;
		ArrayList<Film> clusterCorrente;
		Random generator = new Random();
		ArrayList<Film> suggerimenti = new ArrayList<Film>();
		int numEstrazioniCluster = 0;
		int indexEstrazione;
		
		
		for(int cluster = 0; cluster < KMeansExecutor.NUM_CLUSTER; cluster++) {
			clusterCorrente = KMeansExecutor.getFilmFromCluster(cluster, username); 
			
			estrazioneCorrente = datiDAO.retrieveByKey(username, cluster);
			numEstrazioniCluster = (estrazioneCorrente != null) ? estrazioneCorrente.getNumeroEstrazione() : 0;

			while(numEstrazioniCluster > 0 && !clusterCorrente.isEmpty()) {
				indexEstrazione = generator.nextInt(clusterCorrente.size());
				suggerimenti.add(clusterCorrente.get(indexEstrazione));
				clusterCorrente.remove(indexEstrazione); //per evitare di consigliare lo stesso film più volte
				numEstrazioniCluster--;
			}
		}
		
		return suggerimenti;
	}
	
}
