package controller.admin.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.attend.Attend;
import dto.board.Board;
import service.board.boardService;

@WebServlet(name = "adminBoardView", urlPatterns = { "/admin/board/view" })
public class view extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public view() {
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
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		if(admin==null){
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('관리자 전용 페이지 입니다.');");
			out.println("location.href='../home'");
			out.println("</script>");
		}else{
			String mode = request.getParameter("mode");	
			String action = request.getParameter("action");
			Long no = (request.getParameter("no") != null)?Long.valueOf(request.getParameter("no")):0L;
			
			boardService bs = new boardService();
			Board dto = null;
			List<Attend> dto2 = null;
				
			int page = 0;
			if(no > 0) {				
				dto = bs.getBoard(no);
				dto2 = bs.getAttned(no);
				page = (request.getParameter("page") != null )?Integer.parseInt(request.getParameter("page")):0;
			}
			
			request.setAttribute("b", dto);
			request.setAttribute("a", dto2);
			request.setAttribute("page", page);
			request.setAttribute("mode", mode);
			request.setAttribute("action", action);
			RequestDispatcher dis = request.getRequestDispatcher("./view.jsp");
			dis.forward(request, response);
			
			
		}
	}

}
