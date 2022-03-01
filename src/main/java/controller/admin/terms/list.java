package controller.admin.terms;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.information.Information;
import service.information.imformationService;

@WebServlet(name = "adminTermsList", urlPatterns = { "/admin/terms/list" })
public class list extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public list() {
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
		HttpSession session = request.getSession();
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		if(admin==null){
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('관리자 전용 페이지 입니다.');");
			out.println("location.href='../home'");
			out.println("</script>");
		}else{
		
			String title = (request.getParameter("title") != null)?request.getParameter("title"):"이용약관";
			
			imformationService ifm = new imformationService();
			
			List<Information> list = ifm.list(); 
			
			request.setAttribute("list", list);
			request.setAttribute("title", title);
			
			RequestDispatcher dis = request.getRequestDispatcher("/admin/terms/index.jsp");
			dis.forward(request, response);
		}
	}

}
