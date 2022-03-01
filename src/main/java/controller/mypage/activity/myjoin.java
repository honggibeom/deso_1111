package controller.mypage.activity;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.board.Board;
import dto.member.Member;
import service.board.boardService;

@WebServlet(name = "mypageActivityMyJoin", urlPatterns = { "/mypage/activity/myjoin" })
public class myjoin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public myjoin() {
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
		
		if(member==null) {			
			String icon = "error", msg = "회원 전용 페이지 입니다. 로그인 해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../../index");
		}else {
			
			boardService bs = new boardService();
			String kind = request.getParameter("kind");
			
			String title = request.getParameter("title");
			List<Board> list = bs.joinboard(member.getM_no(),kind); 
			
			if(session.getAttribute("referer") != null) {
				session.removeAttribute("referer");
			}
			String referer = request.getRequestURI()+"?"+URLEncoder.encode(request.getQueryString());
			
			
			request.setAttribute("referer", referer);
			request.setAttribute("title", title);
			request.setAttribute("list", list);
			RequestDispatcher dis = request.getRequestDispatcher("./myboard.jsp");
			dis.forward(request, response);
		}
	}

}
