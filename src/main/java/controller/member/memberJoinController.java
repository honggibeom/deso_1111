package controller.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import service.member.memberService;

/**
 * Servlet implementation class memberJoinController
 */
@WebServlet("/member/join")
public class memberJoinController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public memberJoinController() {
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
		
		String id = (request.getParameter("uId") != null)?request.getParameter("uId"):"";
		String pw = (request.getParameter("uPwd") != null)?request.getParameter("uPwd"):"";
		String name = (request.getParameter("uNick") != null)?request.getParameter("uNick"):"";
		String school = (request.getParameter("ucol") != null)?request.getParameter("ucol"):"";
		String study = (request.getParameter("study") != null)?request.getParameter("study"):"";
		String year = (request.getParameter("year") != null)?request.getParameter("year"):"";
		String month = (request.getParameter("month") != null)?request.getParameter("month"):"";
		String day = (request.getParameter("day") != null)?request.getParameter("day"):"";
		String phone = (request.getParameter("uTel") != null)?request.getParameter("uTel"):"";
						
		memberService ms = new memberService();
				
		if(id != "" && pw != "" && name != "" && school != "" && study != "" && year != "" && month != "" && day != "" && phone != "") {	
			String birth = year+"/"+month+"/"+day;
			
			int insert = ms.memberJoin(id,pw,name,school,study,birth,phone);
			if(insert > 0) {
				session.setAttribute("id", id);
				String icon = "success", msg = "회원가입 성공하였습니다. 학교인증해주세요.";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect("./student");
			}else {			
				String icon = "error", msg = "회원가입 실패하였습니다.";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect(request.getHeader("referer"));
			}
		}else {
			String icon = "error", msg = "회원가입 실패하였습니다.(빈칸이 있는지 확인해주세요.)";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect(request.getHeader("referer"));
		}
		
		
	}

}
