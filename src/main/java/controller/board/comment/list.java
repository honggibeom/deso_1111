package controller.board.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
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


@WebServlet(name = "commentList", urlPatterns = { "/board/comment/list" })
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
			Long mno = Long.valueOf(request.getParameter("mno"));
			
			commentService cs = new commentService();
	 		
			List<Comment> list = cs.list(no);
						
			//대댓글
			Comment dto = null;
			int size = list.size();

			for(int i=0; i<list.size(); i++) {
				List<Long> nos = cs.childComment(list.get(i).getC_group());
				if(nos.size() > 0) {
					for(int j=0; j<nos.size(); j++) {
						dto = cs.getComment(nos.get(j));
						list.get(i).getComment().add(dto);
						size++;
					}
				}
			}
				
			
			request.setAttribute("size", size);
			request.setAttribute("no", no);
			request.setAttribute("mno", mno);
			request.setAttribute("list", list);
		
			RequestDispatcher dis = request.getRequestDispatcher("./list.jsp");
			dis.forward(request, response);
		}
	}
	

}
