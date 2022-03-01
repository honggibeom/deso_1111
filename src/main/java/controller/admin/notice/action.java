package controller.admin.notice;

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
import dto.notice.Notice;
import service.admin.noticeService;

@WebServlet(name = "noticeAction", urlPatterns = { "/admin/notice/action" })
public class action extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public action() {
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
			noticeService ns = new noticeService();
			Notice dto = new Notice();
			if(request.getParameter("no") != null) {				
				int no = Integer.parseInt(request.getParameter("no"));
				
				dto = ns.getNotice(no);
				request.setAttribute("notice", dto);
			}
			
			
			int page = ((request.getParameter("page") != null)?Integer.parseInt(request.getParameter("page")):0);
			String action = request.getParameter("action");
			request.setAttribute("page", page);
			request.setAttribute("action", action);
		
			
			RequestDispatcher dis = request.getRequestDispatcher("./action.jsp");
			dis.forward(request, response);	
			
		}
	}

}
