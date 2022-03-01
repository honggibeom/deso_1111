package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class adminLogoutController
 */
@WebServlet("/admin/logout")
public class adminLogoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public adminLogoutController() {
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
		
		session.removeAttribute("admin");
		
		PrintWriter out = response.getWriter();
		
		out.println("<script>");
		out.println("alert('로그아웃되었습니다.');");
		out.println("location.href='./index.jsp'");
		out.println("</script>");
		
		
	}

}
