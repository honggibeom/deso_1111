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

/**
 * Servlet implementation class adminModifyController
 */
@WebServlet("/admin/modify")
public class adminModifyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public adminModifyController() {
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
		PrintWriter out = response.getWriter();
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		
		String realPw = admin.getAdmin_pw();
		String pw = request.getParameter("pw");
		String newPw = request.getParameter("newPw");
		
		
		if(!realPw.equals(pw)) {
			out.println("<script>");
			out.println("alert('비밀번호가 일치하지않습니다.1');");
			out.println("history.back();");
			out.println("</script>");
		}else {
			adminService as = new adminService();
			int mod = as.adminModify(admin,newPw);
			
			if(mod > 0) {
				out.println("<script>");
				out.println("location.href='./account/success.jsp'");
				out.println("</script>");
			}else {
				out.println("<script>");
				out.println("alert('수정 실패하였습니다.');");
				out.println("history.back();");
				out.println("</script>");
			}
		}
		
	}

}
