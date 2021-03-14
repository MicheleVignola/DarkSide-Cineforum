package cineforum.fia;

import java.math.BigDecimal;

import weka.clusterers.SimpleKMeans;
import weka.clusterers.kvalid.SilhouetteIndex;
import weka.core.EuclideanDistance;
import weka.core.Instances;
import weka.core.ManhattanDistance;
import weka.experiment.InstanceQuery;
import weka.filters.Filter;
import weka.filters.unsupervised.attribute.Remove;

public class KMeansEvaluator {

	public static void main(String[] args) throws Exception {
		
		//recupero il dataset
		InstanceQuery query = new InstanceQuery();
		query.setDatabaseURL("jdbc:mysql://localhost:3306/cineforum?serverTimezone=UTC");
		query.setUsername("cineadmin");
		query.setPassword("Cine.123");
		query.setQuery("select f.CodiceFilm, f.Genere, f.Classificazione, f.Studio, f.Durata from film AS f");
		Instances data =  query.retrieveInstances();

		int[] attributes = new int[2];
		attributes[0] = 0; //CodiceFilm
		attributes[1] = 4; //Durata
		
		Remove remove = new Remove();
		remove.setAttributeIndicesArray(attributes);
		remove.setInputFormat(data);
		Instances dataClusterer = Filter.useFilter(data, remove);
		
		
		int bestK = 0, bestSeed = 0;
		double maxSilhouette = 0;

		System.out.println("Inizio ciclo for...");
		System.out.println("");
		
	
		for(int seed = 0; seed <= 200; seed++) {
			for(int k = 2; k <= 40; k++) {
				
				//EuclideanDistance df = new EuclideanDistance();
				ManhattanDistance df = new  ManhattanDistance();

				df.setAttributeIndices("first-last");
				
				SimpleKMeans cl = new SimpleKMeans();
				cl.setPreserveInstancesOrder(true);
				cl.setSeed(seed);
				cl.setNumClusters(k);
				cl.setDistanceFunction(df);
				cl.buildClusterer(dataClusterer);
				
				SilhouetteIndex si = new SilhouetteIndex();
				si.evaluate(cl, cl.getClusterCentroids(), dataClusterer, df);
				BigDecimal valueSilhouette = (Double.isNaN(si.getGlobalSilhouette())) ? BigDecimal.valueOf(0) : BigDecimal.valueOf(si.getGlobalSilhouette());
				
				if ( valueSilhouette.compareTo(BigDecimal.valueOf(maxSilhouette)) == 1 ) {
					maxSilhouette = Double.parseDouble(valueSilhouette.toString());
					bestK = k;
					bestSeed = seed;
				}
				
			}
		}
		
		System.out.println("Miglior valore per K: " + bestK + " Miglior valore per Seed: " + bestSeed + " Massimo valore Silhouette: " + maxSilhouette);	
		//Miglior valore per K: 39 Miglior valore per Seed: 199 Massimo valore Silhouette: 0.8747886190828532
	}

}
