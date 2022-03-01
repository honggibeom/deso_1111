package controller.board;

import java.io.IOException;
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
import dto.board.Board;
import dto.comment.Comment;
import dto.member.Member;
import service.board.boardService;
import service.board.comment.commentService;
import service.member.memberService;


@WebServlet(name = "boardView", urlPatterns = { "/board/view" })
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
		
		Member member = (Member)session.getAttribute("member");
				
		boardService bs = new boardService();
		memberService ms = new memberService();
				
		Long no = (request.getParameter("no")!=null)?Long.valueOf(request.getParameter("no")):0L;

 		
		Board b = bs.getBoard(no);
		
		
		if(b != null) {	
			
			String referer = (request.getParameter("referer")!=null)?request.getParameter("referer"):null;
			if(referer != null) {
				if(String.valueOf(referer.charAt(0)).equals("/")) {
					referer = referer.substring(1, referer.length()); 
				}
				session.setAttribute("referer", referer);
			}
			
			Member m = ms.getMember(b.getB_m_no());
			
			List<Attend> a = bs.getAttned(no);
			
			commentService cs = new commentService();
			
			List<Comment> c = cs.list(no);
			
			//대댓글
			Comment dto = null;
			
			for(int i=0; i<c.size(); i++) {
				List<Long> nos = cs.childComment(c.get(i).getC_group());
				if(nos.size() > 0) {
					for(int j=0; j<nos.size(); j++) {
						dto = cs.getComment(nos.get(j));
						c.get(i).getComment().add(dto);
					}
				}
			}
						
			//여부
			Boolean state = false;
			Boolean attendFl = false;
			if(member != null) {			
				for(int i=0; i<a.size(); i++) {
					if(a.get(i).getM_no() == member.getM_no()) {
						attendFl = true;
						if(a.get(i).getKind()) {
							state = true;
						}
					}
				}
			}
								
			request.setAttribute("member", m);		
			request.setAttribute("board", b);
			request.setAttribute("attend", a);
			request.setAttribute("comment", c);
			request.setAttribute("attendFl", attendFl);
			request.setAttribute("state", state);
			RequestDispatcher dis = request.getRequestDispatcher("./view.jsp");
			dis.forward(request, response);
		}else {
			String icon = "error", msg = "유효하지않은 페이지입니다.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../index");
		}
		
		
		
	}

}
