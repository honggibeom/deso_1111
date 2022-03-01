package controller.friend;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.member.Member;
import service.friend.friendService;
import service.member.memberService;

/**
 * Servlet implementation class friend
 */
@WebServlet("/friend")
public class friend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public friend() {
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
			response.sendRedirect("./index");
		}else{
			Long no = Long.valueOf(request.getParameter("no")); //친구번호
			
					
			memberService cs = new memberService();
			friendService fs = new friendService();
			
			Member m = cs.getMember(no);
			
			//친구조회
			Long fno = fs.selectFriend(member.getM_no(),no); 		
			
			
			if(member.getM_no() != no) {				
				request.setAttribute("fno", fno);
				request.setAttribute("no", no);
				request.setAttribute("m", m);
				request.setAttribute("referer", request.getHeader("referer"));
				
				RequestDispatcher dis = request.getRequestDispatcher("./friend/friend.jsp");
				dis.forward(request, response);
			}else {
				response.sendRedirect("mypage");
			}
			
		}
	}

}
