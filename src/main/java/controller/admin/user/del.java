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
import service.admin.userService;


/**
 * Servlet implementation class del
 */
@WebServlet("/admin/user/del")
public class del extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public del() {
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
			
			int no = Integer.parseInt(request.getParameter("no"));
			int page = Integer.parseInt(request.getParameter("page"));
			String mode = request.getParameter("mode");
			
			int del = ms.del(no);
			
			if(del > 0) {
				request.setAttribute("page", page);
				if(mode.equals("일반회원")) {					
					RequestDispatcher dis = request.getRequestDispatcher("./list");
					dis.forward(request, response);	
				}else {
					RequestDispatcher dis = request.getRequestDispatcher("./unsubs");
					dis.forward(request, response);	
				}
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
