package cineforum.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cineforum.fia.KMeansExecutor;
import cineforum.model.DatiEstrazioneSuggerimenti;
import cineforum.model.DatiEstrazioneSuggerimentiDAO;
import cineforum.model.Lista;
import cineforum.model.ListaDAO;

/**
 * Gestisce le operazioni di inserimento, modifica e eliminazione di un film nella lista di un utente
 * 
 */
@WebServlet("/ListaOperation")
public class ListaOperationControl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ListaOperationControl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
		return;
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = (String) request.getParameter("action");
		Lista bean = null;
		ListaDAO listaOp = null;
		String requestPage = request.getHeader("referer");
		
		int newNumeroEstrazione;
		int numCluster = -1;
		DatiEstrazioneSuggerimentiDAO datiDAO = new DatiEstrazioneSuggerimentiDAO();
		DatiEstrazioneSuggerimenti estrazioneCorrente = null;
		
		if (action != null) {
			bean = new Lista();
			listaOp = new ListaDAO();
			
			bean.setCodiceFilm(Integer.parseInt(request.getParameter("codiceFilm")));
			bean.setUsername(request.getParameter("username"));
			bean.setCategoria(request.getParameter("categoria"));
			
			try {
				numCluster = KMeansExecutor.getNumClusterFilm(bean.getCodiceFilm());
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			estrazioneCorrente = datiDAO.retrieveByKey(bean.getUsername(), numCluster);
			
			if (estrazioneCorrente == null) {
				estrazioneCorrente = new DatiEstrazioneSuggerimenti();
				estrazioneCorrente.setCluster(numCluster);
				estrazioneCorrente.setUsername(bean.getUsername());
				estrazioneCorrente.setNumeroEstrazione(0);
				datiDAO.save(estrazioneCorrente);
			}
			
			switch(action) {
				case "insert":
					bean.setVoto(Short.parseShort(request.getParameter("voto")));
					listaOp.save(bean);
					
					if(bean.getCategoria().equals("visti")) { //modifico i dati relativi all'estrazione dei suggerimento solo se il film viene aggiunto alla categoria "visti"
						newNumeroEstrazione = estrazioneCorrente.getNumeroEstrazione() + getNumeroEstrazioni(Integer.parseInt(request.getParameter("voto")));
						estrazioneCorrente.setNumeroEstrazione(newNumeroEstrazione);
						datiDAO.update(estrazioneCorrente);
					}
					
					break;
				case "edit":
					Lista oldBean = listaOp.retrieveByKey(bean.getCodiceFilm(), bean.getUsername());
					int oldVoto = oldBean.getVoto(); //recupero vecchio voto poichè non presente nella request
					String oldCategoria = oldBean.getCategoria(); //recupero vecchia categoria, nel caso sia modificata, poichè non presente nella request
					
					bean.setVoto(Short.parseShort(request.getParameter("voto")));
					listaOp.update(bean);
					
					//Ora modifico i dati relativi all'estrazione dai cluster, ci sono 3 possibilità
					if (oldCategoria.equals("in programma") && bean.getCategoria().equals("visti")) {
						//Se il film passa da categoria "in programma" a "visti", va semplicemente fatta un'addizione
						
						newNumeroEstrazione = estrazioneCorrente.getNumeroEstrazione() + getNumeroEstrazioni(Integer.parseInt(request.getParameter("voto")));
						estrazioneCorrente.setNumeroEstrazione(newNumeroEstrazione);
						datiDAO.update(estrazioneCorrente);
					} else if (oldCategoria.equals("visti") && bean.getCategoria().equals("in programma")) {
						//Se il film passa da categoria "visti" a "in programma", va fatta una sottrazione poichè l'estrazione deve tenere conto solo dei film
						//presenti nella categoria "visti
						
						newNumeroEstrazione = estrazioneCorrente.getNumeroEstrazione() - getNumeroEstrazioni(oldVoto);
						estrazioneCorrente.setNumeroEstrazione(newNumeroEstrazione);
						datiDAO.update(estrazioneCorrente);
					} else if(bean.getCategoria().equals("visti")) { 
						//A questo punto, l'unica alternativa rimanente è che al film viene modificato solo il voto ed è nella categoria "visti" quindi
						//bisogna prima sottrarre e poi aggiungere, per adattare l'estrazione al nuovo voto
						
						newNumeroEstrazione = estrazioneCorrente.getNumeroEstrazione() - getNumeroEstrazioni(oldVoto);
						estrazioneCorrente.setNumeroEstrazione(newNumeroEstrazione);
												
						newNumeroEstrazione = estrazioneCorrente.getNumeroEstrazione() + getNumeroEstrazioni(Integer.parseInt(request.getParameter("voto")));
						estrazioneCorrente.setNumeroEstrazione(newNumeroEstrazione);
						datiDAO.update(estrazioneCorrente);
					}
					
					break;
					
				case "remove":
					int voto = listaOp.retrieveByKey(bean.getCodiceFilm(), bean.getUsername()).getVoto(); //recupero voto poich� non presente nella request
					
					listaOp.delete(bean);
					
					if(bean.getCategoria().equals("visti")) { //modifico i dati relativi all'estrazione dei suggerimento solo se il film eliminato era nella categoria "visti"
						newNumeroEstrazione = estrazioneCorrente.getNumeroEstrazione() - getNumeroEstrazioni(voto);
						estrazioneCorrente.setNumeroEstrazione(newNumeroEstrazione);
						datiDAO.update(estrazioneCorrente);
					}
					
					break;
			}
		}
		
		response.sendRedirect(response.encodeURL(requestPage));
	}

	/**
	 * Calcola il numero di estrazioni in base al voto
	 * @param voto Voto su cui calcolare il  numero di estrazioni
	 * @return numero di estrazioni
	 */
	private int getNumeroEstrazioni(int voto) {
		if (voto <= 4)
			return 0;
		else if (voto == 5 || voto == 6)
			return 1;
		else if (voto == 7 || voto == 8)
			return 2;
		else
			return 3;
	}
}
