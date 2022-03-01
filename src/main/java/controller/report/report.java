package controller.report;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.member.Member;


@WebServlet(name = "reportPage", urlPatterns = { "/report/page" })
public class report extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public report() {
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
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../index");
		}else{
			String mode = request.getParameter("mode");
			Long no = (request.getParameter("no") != null)?Long.valueOf(request.getParameter("no")):0L;
			String title = (request.getParameter("title") != null)?request.getParameter("title"):null;
			Long rd_m_no = (request.getParameter("rd_m_no") != null)?Long.valueOf(request.getParameter("rd_m_no")):0L;
			String rd_m_id = (request.getParameter("rd_m_id") != null)?request.getParameter("rd_m_id"):null;
			

			request.setAttribute("mode", mode);
			request.setAttribute("no", no);
			request.setAttribute("title", title);
			request.setAttribute("rd_m_no", rd_m_no);
			request.setAttribute("rd_m_id", rd_m_id);
			request.setAttribute("referer", request.getHeader("referer"));
			
			RequestDispatcher dis = request.getRequestDispatcher("/report/report.jsp");
			dis.forward(request, response);
			
		}
	}

}
