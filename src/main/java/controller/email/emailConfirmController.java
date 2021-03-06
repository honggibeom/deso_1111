package controller.email;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class emailConfirmController
 */
@WebServlet("/emailConfirm")
public class emailConfirmController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public emailConfirmController() {
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
		
			
		String val = ((String)session.getAttribute("email") != null)?(String)session.getAttribute("email"):"";
		
		String number = request.getParameter("en");
		
		int data = 0;
		
		if(val != null) {			
			if(val.equals(number)) {
				data = 1;
				session.removeAttribute("email");
			}else{
				data = 0;
			}
		}else {
			data = 2;
		}
		
		PrintWriter out = response.getWriter();
		out.println(data);
		
	}

}
