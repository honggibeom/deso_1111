package controller.main;

import java.io.IOException;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.allim.Allim;
import dto.banner.Banner;
import dto.board.Board;
import dto.member.Member;
import dto.notice.Notice;
import service.allim.allimService;
import service.main.mainService;
import service.notice.noticeService;

@WebServlet("/main")
public class mainController extends HttpServlet {
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
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("./index");
		}else{
			if(session.getAttribute("referer") != null) {
				session.removeAttribute("referer");
			}
			mainService ms = new mainService(); 
			
			noticeService ns = new noticeService();
			
			List<Notice> list = ns.noticeList();
	 		
						
			List<Board> meet = ms.meetList();
			List<Board> event = ms.eventList();
							
			Banner banner = ms.bannerList();
			
			session.setAttribute("count", list.size());
			request.setAttribute("banner", banner);
			request.setAttribute("meet", meet);
			request.setAttribute("event", event);
			
			RequestDispatcher dis = request.getRequestDispatcher("main/main.jsp");
			dis.forward(request, response);
			
		}
		
	}

}
