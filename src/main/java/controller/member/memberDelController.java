package controller.member;

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
import service.member.memberService;

@WebServlet("/member/del")
public class memberDelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public memberDelController() {
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
			memberService ms = new memberService();
			String content = request.getParameter("del_content");
			int del = ms.del(member.getM_no(),content);
			
			if(del > 0) {
				String icon = "sueecss", msg = "삭제되었습니다.";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				session.removeAttribute("member");
				response.sendRedirect("../index");
			}else {
				String icon = "error", msg = "삭제 실패";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect(request.getHeader("referer"));
			}
		}
	}

}
