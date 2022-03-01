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


@WebServlet(name = "noticeProcess", urlPatterns = { "/admin/notice/process" })
public class process extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public process() {
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
			noticeService ns = new noticeService();
						
			String action = request.getParameter("action");
			int page = ((request.getParameter("page") != null)?Integer.parseInt(request.getParameter("page")):0);
			
			int no = ((request.getParameter("no") != null)?Integer.parseInt(request.getParameter("no")):0);
			String id = admin.getAdmin_id();
			String title = (request.getParameter("title") != null)?request.getParameter("title"):null;
			String content = (request.getParameter("content") != null)?request.getParameter("content"):null;
			int sort = ((request.getParameter("noticeSort") != null)?Integer.parseInt(request.getParameter("noticeSort")):0);
			
			int process = ns.process(no,id,title,content,sort,action);
			
			if(process > 0) {				
				request.setAttribute("page", page);
				request.setAttribute("action", action);
				RequestDispatcher dis = request.getRequestDispatcher("./list");
				dis.forward(request, response);	
			}else {
				PrintWriter out = response.getWriter();
				
				out.println("<script>");
				out.println("alert('"+action+"실패');");
				out.println("history.back();");
				out.println("</script>");
			}
			
		}
	}

}
