package controller.board.attend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.member.Member;
import service.board.boardService;
import service.board.attend.attendService;

@WebServlet(name = "boardAttend", urlPatterns = { "/board/attend" })
public class attend extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public attend() {
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
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../index");
		}else{
			int bol = Integer.parseInt(request.getParameter("attend"));
			Long no = Long.valueOf(request.getParameter("no"));
			String kind = request.getParameter("kind");
			
			attendService as = new attendService();
			boardService bs = new boardService();
			
			int process = 0;
			if(bol == 2) { // 참여
				process = as.attend(no,member.getM_no(),member.getM_name(),member.getM_img1(),kind);
				if(kind.equals("모임")) {					
					bs.count(1,no);
				}else {
					bs.pCount(1,no);
				}
			}else if(bol == 0 || bol ==1){ //참여취소
				process = as.unAttend(no,member.getM_no());
				if(bol == 0) {
					bs.count(-1,no);
				}else {
					bs.pCount(-1,no);
				}
			}
			
			if(process > 0) {
				String icon=null,msg=null;
				if(bol == 2) {
					if(kind.equals("모임")) {						
						icon = "success"; msg = "참여되었습니다. 반장 승인 후 참여자로 전환됩니다.";
					}else {
						icon = "success"; msg = "참여되었습니다.";
					}
				}else {
					icon = "success"; msg = "취소되었습니다.";	
				}
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect("./view?no="+no);			
			}else {
				String icon = "error", msg = "오류";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect(request.getHeader("referer"));
			}
			
		}
	}

}
