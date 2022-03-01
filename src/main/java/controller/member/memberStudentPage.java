package controller.member;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;

/**
 * Servlet implementation class memberStudentAuthPage
 */
@WebServlet("/member/student")
public class memberStudentPage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public memberStudentPage() {
        super();
        // TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		HttpSession session = request.getSession();
				
		if(session.getAttribute("id") != null || request.getParameter("id") != null) {
			RequestDispatcher dis = request.getRequestDispatcher("../account/student_auth.jsp");
			dis.forward(request, response);
		}
		else {			
			String icon = "error", msg = "잘못된 접근입니다.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect(request.getHeader("referer"));
		}
		
	}

}
