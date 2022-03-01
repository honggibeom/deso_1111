package controller.member;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.member.Member;
import service.member.memberService;

/**
 * Servlet implementation class memberStudentConfirm
 */
@WebServlet("/member/student/confirm")
public class memberStudentConfirm extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public memberStudentConfirm() {
        super();
        // TODO Auto-generated constructor stub
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
		
		String id = null;

		if((String)session.getAttribute("id") != null) {
			id = (String)session.getAttribute("id");
			session.removeAttribute("id");
		}else if((Member)session.getAttribute("member") != null) {
			Member mem = (Member)session.getAttribute("member");
			session.removeAttribute("member");			
			id = mem.getM_id();
		}
		
		String mail = request.getParameter("mail");
				
		memberService ms = new memberService();
		
		int insert = ms.studentConfirm(id,mail);
		
		if(insert > 0) {
			Member m = ((Member)session.getAttribute("member") != null)?(Member)session.getAttribute("member"):ms.getMember2(id);
			
			Member member = ms.getMember(m.getM_no());
			session.setAttribute("member", member);
			
			String icon = "success", msg = "인증되었습니다.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			
			response.sendRedirect("../../main");
		}else {
			session.removeAttribute("id");
			String icon = "error", msg = "실패, 관리자에게 문의주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../../index");
		}
		
		
	}

}
