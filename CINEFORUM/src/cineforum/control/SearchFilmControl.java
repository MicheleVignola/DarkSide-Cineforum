package cineforum.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import cineforum.model.Film;
import cineforum.model.FilmDAO;

/**
 * Gestisce l'operazione di ricerca effettuata nella pagina della raccolta dei film o sulla pagina della gestione film
 *
 */
@WebServlet("/SearchFilm")
public class SearchFilmControl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public SearchFilmControl() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out = response.getWriter();
		response.setContentType("text/plain");

		out.write("Error: GET method is used but POST method is required");
		out.close();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		JSONObject jsonObj = new JSONObject(request.getParameter("json"));
		JSONObject jsonResponse = new JSONObject(); //json da inviare nella response
		JSONObject jsonTemp = null;
		JSONArray jsonArr = new JSONArray(); //array contenente tutti i film trovati dalla ricerca
		ArrayList<Film> lista = null;
		FilmDAO filmOp = new FilmDAO();
		
		lista = filmOp.retrieveAll(FilmDAO.BY_TITLE, jsonObj.getString("titolo"));
		
		if (lista.isEmpty()) {
			jsonTemp = new JSONObject();
			jsonTemp.put("titolo", "nessun film presente con questo titolo");
			jsonTemp.put("codiceFilm", "");
			jsonArr.put(jsonTemp);
		} else {
			for (Film element : lista) {
				jsonTemp = new JSONObject();
				jsonTemp.put("titolo", element.getTitolo());
				jsonTemp.put("codiceFilm", element.getCodiceFilm());
				jsonTemp.put("immagine", element.getImmagine());
				jsonArr.put(jsonTemp);
			}
		}
		jsonResponse.put("lista", jsonArr);
			
		response.setContentType("application/json");
		response.getWriter().write(jsonResponse.toString());
	}

}
