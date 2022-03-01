package controller.admin.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.member.Member;
import service.admin.userService;
import service.member.memberService;

/**
 * Servlet implementation class user
 */
@WebServlet("/admin/user/user")
public class user extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public user() {
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
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		if(admin==null){
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('관리자 전용 페이지 입니다.');");
			out.println("location.href='../home'");
			out.println("</script>");
		}else{
			memberService ms = new memberService();			
			
			Long no = Long.valueOf(request.getParameter("no"));
			Member dto = ms.getMember(no);
			
			int page = Integer.parseInt(request.getParameter("page"));
			String mode = request.getParameter("mode");
			
			request.setAttribute("page", page);
			request.setAttribute("m", dto);
			request.setAttribute("mode", mode);
		
			
			RequestDispatcher dis = request.getRequestDispatcher("./detail.jsp");
			dis.forward(request, response);	
		}
		
	}

}
