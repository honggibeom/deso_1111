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

/**
 * Servlet implementation class modify
 */
@WebServlet("/admin/user/modify")
public class modify extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public modify() {
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
			userService ms = new userService();
			
			Member member = new Member();
			member.setM_no(Long.parseLong(request.getParameter("no")));
			member.setM_id(request.getParameter("id"));
			member.setM_pw(request.getParameter("pw"));
			member.setM_name(request.getParameter("name"));
			member.setM_school(request.getParameter("school"));
			member.setM_email(request.getParameter("email"));
			member.setM_phone(request.getParameter("phone"));
			member.setM_address_sub(request.getParameter("address"));
			
			int page = Integer.parseInt(request.getParameter("page"));
			
			int mod = ms.modify(member);
			
			if(mod > 0) {
				request.setAttribute("page", page);
				RequestDispatcher dis = request.getRequestDispatcher("./list");
				dis.forward(request, response);	
			}else {
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
			
		}
		
	}

}
