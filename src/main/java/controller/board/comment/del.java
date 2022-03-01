package controller.board.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.comment.Comment;
import dto.member.Member;
import service.board.comment.commentService;

@WebServlet(name = "commentDel", urlPatterns = { "/board/comment/del" })
public class del extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public del() {
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
		
		PrintWriter out = response.getWriter();		
		HttpSession session = request.getSession();
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../../index");
		}else{
			Comment dto = new Comment();
			dto.setC_no(Long.valueOf(request.getParameter("no")));
			dto.setC_group(Long.valueOf(request.getParameter("gno")));		
			dto.setC_parentFl(Boolean.valueOf(request.getParameter("parentFl")));
			
			commentService cs = new commentService();
			
			int process = 0;
			if(!dto.getC_parentFl()) {
				//대댓글
				List<Long> nos = cs.childComment(dto.getC_group());
				if(nos.size() > 0) {
					for(int j=0; j<nos.size(); j++) {
						cs.del(nos.get(j));
					}
				}
				
			}			
			
			process = cs.del(dto.getC_no());
			String msg = "x";
			if(process > 0) {
				msg = "o";
			}else {
				msg = "x";
			}
			out.println(msg);

			
			
		}
	}

}
