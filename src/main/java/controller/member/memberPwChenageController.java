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
 * Servlet implementation class memberPwChenageController
 */
@WebServlet("/member/pwChenage")
public class memberPwChenageController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public memberPwChenageController() {
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
  		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
  		
  		Long no = 0L;
  		
  		if(session.getAttribute("no") != null) {
  			no = (Long)session.getAttribute("no");
  		}else if(session.getAttribute("member") != null){
  			Member member = (Member)session.getAttribute("member");
  			no = member.getM_no();
  		}
  		
  		String pw = request.getParameter("uPwd");
  		
  		memberService ms = new memberService();
  		
  		if(no > 0) {
  			int update = ms.chenagePw(no,pw);
  			
  			if(update > 0) {
  				if(session.getAttribute("no") != null) {  					
  					session.removeAttribute("no");
  				}else if(session.getAttribute("member") != null){
  					session.removeAttribute("member");  					
  				}
 
  				String icon = "success", msg = "변경완료되었습니다. 바뀐 번호로 로그인해주세요..";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect("../index");
  				
  			}
  		}else {
  			String icon = "error", msg = "오류";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../index");
  		}
  		
  		
  	}

}
