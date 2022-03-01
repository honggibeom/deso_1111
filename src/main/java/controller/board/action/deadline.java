package controller.board.action;

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
import service.board.boardService;

@WebServlet(name = "boardDeadline", urlPatterns = { "/board/deadline" })
public class deadline extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public deadline() {
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
			Long no = Long.valueOf(request.getParameter("no"));
			
			boardService bs = new boardService();
			
			int process = bs.deadline(no); 
			if(process > 0) {
				String icon = "success", msg = "모임완료처리되었습니다.";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect("./view?no="+no+"");
			}
		}
	}

}
