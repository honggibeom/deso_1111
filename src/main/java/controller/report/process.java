package controller.report;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.member.Member;
import dto.report.Report;
import service.admin.reportService;

/**
 * Servlet implementation class process
 */
@WebServlet(name = "reportProcess2", urlPatterns = { "/report/process" })
public class process extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
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
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../index");
		}else{
			Report r = new Report();
			r.setR_content(request.getParameter("content"));
			r.setR_title(request.getParameter("title"));
			r.setR_kind(request.getParameter("mode"));
			r.setR_id(member.getM_id());
			if(r.getR_kind().equals("회원")) {
				r.setRd_id_no(Long.valueOf(request.getParameter("rd_id_no")));
				r.setRd_id(request.getParameter("rd_id"));
			}else {
				r.setRd_board_no(Long.valueOf(request.getParameter("rd_board_no")));
				r.setRd_board_title(request.getParameter("rd_board_title"));
			}
			
			reportService rs = new reportService();
			
			int process = rs.insert(r);
			
			String msg = "x";
			if(process > 0) {
				msg = "o";
			}else {
				msg = "x";
			}
			
			out.print(msg);
			
			
		}
	}

}
