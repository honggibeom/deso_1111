package controller.admin.user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import service.admin.userService;

/**
 * Servlet implementation class mod
 */
@WebServlet("/admin/user/mod")
public class mod extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mod() {
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
			String val = request.getParameter("val");
			int no =  Integer.parseInt(request.getParameter("no"));
			String mode = request.getParameter("mode");
			
			userService am = new userService();

			int mod = am.mod(val,no,mode);
			
			PrintWriter out = response.getWriter();
			int msg = 0;
			if(mod > 0) {
				if(mode.equals("경고횟수") && val.equals("3")) {
					msg = 2;
				}else if(mode.equals("상태") && val.equals("0")) {
					msg = 3;
				}else {
					msg = 1;
				}
				
			}else {
				msg = 0;
			}
			
			out.print(msg);	
		}
		
	}

}
