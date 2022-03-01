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
import dto.report.Report;
import service.admin.reportService;

@WebServlet(name = "reportViewController", urlPatterns = { "/admin/report/view" })
public class view extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public view() {
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
			Report dto = rs.getReport(no);
			
			int page = Integer.parseInt(request.getParameter("page"));
			String sort = request.getParameter("sort");
			
			request.setAttribute("page", page);
			request.setAttribute("r", dto);
			request.setAttribute("sort", sort);
		
			
			RequestDispatcher dis = request.getRequestDispatcher("./view.jsp");
			dis.forward(request, response);	
		}
		
	}

}
