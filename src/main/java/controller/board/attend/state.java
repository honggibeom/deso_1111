package controller.board.attend;

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
import dto.board.Board;
import dto.member.Member;
import service.board.boardService;
import service.board.attend.attendService;

@WebServlet(name = "boardAttendState", urlPatterns = { "/board/attend/state" })
public class state extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public state() {
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
		}else{
			Long no = Long.valueOf(request.getParameter("no")); //mno
			int mode = Integer.parseInt(request.getParameter("mode")); 
			Long b_no = Long.valueOf(request.getParameter("b_no"));
			
			attendService as = new attendService();
			boardService bs = new boardService();
			Board b = bs.getBoard(b_no);
			
			int process = 0;
			if(mode > 0) {	
				if(b.getB_p_limit().equals("제한없음") || b.getB_p_limit().equals("제한 없음")) {					
					process = as.state(no);
					bs.pCount(1,b_no);
				}else {
					if(b.getB_p_count() < Integer.parseInt(b.getB_p_limit())) {
						process = as.state(no);
						bs.pCount(1,b_no);
					}else {
						String icon = "error", msg = "참여자 인원수가 꽉 찼습니다.";
						Alert alert = new Alert(icon, msg);
						alert.save(request, alert);
						response.sendRedirect(request.getHeader("referer"));
					}
				}
				
			}else {
				process = as.unState(no);
			}
			
			if(process > 0) {
				if(b.getB_p_w_count() > 0) {					
					bs.count(-1,b_no);
				}
				
				PrintWriter out = response.getWriter();		
				out.println("<script>");
				out.println("location.href='./list?no="+b_no+"&state=0'");
				out.println("</script>");				
			}else {
				String icon = "error", msg = "오류";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect(request.getHeader("referer"));
			}
			
		}
	}

}
