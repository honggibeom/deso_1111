package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import service.admin.adminService;

@WebServlet("/admin/login")
public class adminLoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public adminLoginController() {
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
		response.setContentType("text/html; charset=utf-8");
		
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		
		adminService als = new adminService();
		Admin dto = als.login(id,pw);
		
		
		PrintWriter out = response.getWriter();
				
		
		if(dto!=null){
			
			HttpSession session = request.getSession();
			session.setAttribute("admin", dto);
			
			response.sendRedirect("./home");
		}else{
			out.println("<script>");
			out.println("alert('등록되지 않은 계정입니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	
		
	}

}
