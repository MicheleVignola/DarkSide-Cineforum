package cineforum.control;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cineforum.fia.SuggerisciFilm;
import cineforum.model.Film;
import cineforum.model.Utente;

@WebServlet("/SuggerimentiFilm")
public class SuggerimentiFilm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SuggerimentiFilm() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		ArrayList<Film> suggerimenti = new ArrayList<Film>();
		
		Utente user = (Utente) session.getAttribute("user");
		
		suggerimenti = SuggerisciFilm.getSuggerimenti(user.getUsername());
		
		request.setAttribute("suggerimenti", suggerimenti);			
		RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/suggerimenti.jsp");
		dispatcher.forward(request, response);
		return;
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
