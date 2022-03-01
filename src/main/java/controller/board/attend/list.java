package controller.board.attend;

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
import dto.attend.Attend;
import dto.member.Member;
import service.board.boardService;
import service.board.attend.attendService;

@WebServlet(name = "boardAttendList", urlPatterns = { "/board/attend/list" })
public class list extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public list() {
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
			Long no = Long.valueOf(request.getParameter("no"));
			int state = Integer.parseInt(request.getParameter("state"));
			attendService as = new attendService();
			
			List<Attend> list = as.list(no,state);
			
			request.setAttribute("list", list);
			request.setAttribute("state", state);
			request.setAttribute("no", no);
			RequestDispatcher dis = request.getRequestDispatcher("./list.jsp");
			dis.forward(request, response);			
		}
	}

}
