package controller.mypage.account;

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
import service.member.memberService;

@WebServlet(name = "mypageAccountPasswordProcess", urlPatterns = { "/mypage/account/password/process" })
public class process extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public process() {
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
		PrintWriter out = response.getWriter();		
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../../../index");
		}else{
			
			memberService ms = new memberService();
			
			String pw = request.getParameter("pwd");
			String newPw = request.getParameter("pwdNew");
			
			String chk = ms.getPw(member.getM_no(),pw);
			
			
			if(chk.equals("o")) {
				int process = ms.chenagePw(member.getM_no(), newPw);
				if(process > 0) {
					session.invalidate();
					response.sendRedirect("../../../index");
				}else {					
					String icon = "error", msg = "실패";
					Alert alert = new Alert(icon, msg);
					alert.save(request, alert);
					response.sendRedirect(request.getHeader("referer"));
					
				}
			}else {				
				String icon = "error", msg = "기존 비밀번호가 틀렸습니다.";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect(request.getHeader("referer"));
			}
			
		}
	}

}
