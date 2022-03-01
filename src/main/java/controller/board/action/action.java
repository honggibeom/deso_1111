package controller.board.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.RequestDispatcher;
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

@WebServlet(name = "boardAction", urlPatterns = { "/board/action" })
public class action extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public action() {
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
			String mode = request.getParameter("mode");
			
			Long no = (request.getParameter("no") != null) ? Long.valueOf(request.getParameter("no")):0L;
			boardService bs = new boardService();
			
			Board dto = new Board();
			
			if(no > 0) {
				dto = bs.getBoard(no);
			}
			
			String referer = (request.getParameter("referer")!=null)?request.getParameter("referer"):null;
			if(referer != null) {
				if(String.valueOf(referer.charAt(0)).equals("/")) {
					referer = referer.substring(1, referer.length()); 
				}
				request.setAttribute("referer", referer);
			}
			
			
			request.setAttribute("board", dto);
			request.setAttribute("mode", mode);
			RequestDispatcher dis = request.getRequestDispatcher("./action.jsp");
			dis.forward(request, response);
		}
		
	}

}
