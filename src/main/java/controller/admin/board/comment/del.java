package controller.admin.board.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.comment.Comment;
import dto.member.Member;
import service.board.comment.commentService;

@WebServlet(name = "adminCommentDel", urlPatterns = { "/admin/comment/del" })
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
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		if(admin==null){		
			out.println("<script>");
			out.println("alert('관리자 전용 페이지 입니다.');");
			out.println("location.href='../home'");
			out.println("</script>");
		}else{
			Comment dto = new Comment();
			dto.setC_no(Long.valueOf(request.getParameter("no")));
						
			commentService cs = new commentService();	
			
			int process = cs.del(dto.getC_no());
		}
	}

}
