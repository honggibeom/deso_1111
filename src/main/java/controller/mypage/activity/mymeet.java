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


@WebServlet(name = "mypageActivityMyMeet", urlPatterns = { "/mypage/activity/mymeet" })
public class mymeet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public mymeet() {
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
			response.sendRedirect("../../index");
		}else {
			boardService bs = new boardService();
			
			String title = request.getParameter("title");
			List<Board> b = bs.myboard(member.getM_no());
			if(session.getAttribute("referer") != null) {
				session.removeAttribute("referer");
			}
			String referer = request.getRequestURI()+"?"+URLEncoder.encode(request.getQueryString());
			
			request.setAttribute("referer", referer);
			request.setAttribute("title", title);			
			request.setAttribute("list", b);
			RequestDispatcher dis = request.getRequestDispatcher("./myboard.jsp");
			dis.forward(request, response);
		}
	}

}
