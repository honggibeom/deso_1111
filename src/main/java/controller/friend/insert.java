package controller.friend;

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
import service.friend.friendService;

@WebServlet(name = "friendInsert", urlPatterns = { "/friend/insert" })
public class insert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public insert() {
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
		}else {
			Long fno = Long.valueOf(request.getParameter("fno"));
			String name = request.getParameter("name");
			String img = request.getParameter("img");
			friendService fs = new friendService();
			
			int process = fs.insert(fno,name,img,member.getM_no());
								
			if(process > 0) {
				response.sendRedirect("/mypage/activity/friend");
			}else {
				String icon = "error", msg = "실패";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect(request.getHeader("referer"));
			}
		}
	}

}
