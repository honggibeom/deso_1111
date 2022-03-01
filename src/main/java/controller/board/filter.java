package controller.board;

import java.io.IOException;
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


@WebServlet(name = "boardListFilter", urlPatterns = { "/board/filter" })
public class filter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public filter() {
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
			String addr = (request.getParameter("addr") != null)?(String)request.getParameter("addr"):"";
			String cate = (request.getParameter("cate") != null)?(String)request.getParameter("cate"):"";
			String date = (request.getParameter("date") != null)?(String)request.getParameter("date"):"";
				
			request.setAttribute("addr", addr);
			request.setAttribute("cate", cate);
			request.setAttribute("date", date);
			request.setAttribute("mode", mode);
			
			RequestDispatcher dis = request.getRequestDispatcher("./filter.jsp");
			dis.forward(request, response);
		}
	}

}
