package controller.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import service.member.memberService;

/**
 * Servlet implementation class findController
 */
@WebServlet("/find/success")
public class findController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public findController() {
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
		
		String mode = request.getParameter("mode");
		String tel = request.getParameter("uTel");
		
		memberService ms = new memberService();
		
		if(mode.equals("id")) {
			String id = ms.findId(tel);
			if(id != null) {				
				request.setAttribute("id", id);
				RequestDispatcher dis = request.getRequestDispatcher("../account/find_id.jsp");
				dis.forward(request, response);
			}else {
				fail(request, response);
			}
			
		}else if(mode.equals("pw")){
			String id = request.getParameter("uId");
			Long no = ms.findPw(tel,id);
			if(no > 0) {
				session.setAttribute("no", no);
				RequestDispatcher dis = request.getRequestDispatcher("../account/find_pwd.jsp");
				dis.forward(request, response);
				
			}else {
				fail(request, response);
			}
		
		}
				
		
	}

	private void fail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String icon = "error", msg = "존재하지 않은 회원입니다.";
		Alert alert = new Alert(icon, msg);
		alert.save(request, alert);
		response.sendRedirect(request.getHeader("referer"));
	}

}
