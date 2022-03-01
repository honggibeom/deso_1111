package controller.admin.report;

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
import service.admin.reportService;

@WebServlet(name = "reportDelController", urlPatterns = { "/admin/report/del" })
public class del extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public del() {
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
			reportService rs = new reportService();			
			
			Long no = Long.valueOf(request.getParameter("no"));
			int page = Integer.parseInt(request.getParameter("page"));
			String sort = request.getParameter("sort");
			
			int del = rs.del(no);
			
			if(del > 0) {
				request.setAttribute("page", page);
				request.setAttribute("sort", sort);
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
