package controller.admin.report;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.board.Board;
import dto.member.Member;
import dto.report.Report;
import service.admin.reportService;
import service.board.boardService;
import service.member.memberService;

@WebServlet(name = "reportController", urlPatterns = { "/admin/report/report" })
public class report extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public report() {
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
		PrintWriter out = response.getWriter();
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		if(admin==null){
			
			out.println("<script>");
			out.println("alert('관리자 전용 페이지 입니다.');");
			out.println("location.href='../home'");
			out.println("</script>");
		}else{
			reportService rs = new reportService();			
			
			Long no = Long.valueOf(request.getParameter("no"));
			
			Long id_no = (request.getParameter("id_no") != null)?Long.valueOf(request.getParameter("id_no")):0L;
			Long board_no = (request.getParameter("board_no") != null)?Long.valueOf(request.getParameter("board_no")):0L;
			int page = Integer.parseInt(request.getParameter("page"));
			String sort = request.getParameter("sort");

			if(id_no > 0) {
				memberService ms = new memberService();
				Member dto = ms.getMember(id_no);
				
				if(!dto.getM_state()) {
					int update = rs.report(id_no,board_no,dto.getM_r_count());
					if(update > 0) {						
						rs.process(no);
						request.setAttribute("page", page);
						request.setAttribute("sort", sort);
						RequestDispatcher dis = request.getRequestDispatcher("./list");
						dis.forward(request, response);	
					}
					
				}else {
					rs.process(no);
					out.println("<script>");
					out.println("alert('이미 정지된 회원입니다.');");
					out.println("history.back();");
					out.println("</script>");
				}
				
			}else if(board_no > 0) {
				boardService bs = new boardService();
				Board dto = bs.getBoard(board_no);
				
				if(!dto.getB_state()) { 
					int update = rs.report(id_no,board_no,dto.getB_r_count());
					if(update > 0) {
						rs.process(no);
						request.setAttribute("page", page);
						request.setAttribute("sort", sort);
						RequestDispatcher dis = request.getRequestDispatcher("./list");
						dis.forward(request, response);	
					}
					
				}else {
					rs.process(no);
					out.println("<script>");
					out.println("alert('이미 정지된 "+sort+"입니다.');");
					out.println("history.back();");
					out.println("</script>");
				}
			}
			
		}
		
	}

}
