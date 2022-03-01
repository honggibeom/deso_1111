package controller.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class memberLogout
 */
@WebServlet("/logout")
public class memberLogout extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public memberLogout() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doProcess(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doProcess(request, response);
	}
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session =request.getSession();
				
		session.invalidate();
		// 특정 쿠키만 삭제하기
	    Cookie c = new Cookie("cookieId", null);
	    c.setMaxAge(0);
	    response.addCookie(c);
		
		RequestDispatcher dispatcher =request.getRequestDispatcher("./index");
		dispatcher.forward(request, response);
	}

}
