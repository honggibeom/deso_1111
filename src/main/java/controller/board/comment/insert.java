package controller.board.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

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

@WebServlet(name = "commentInsert", urlPatterns = { "/board/comment/insert" })
public class insert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public insert() {
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
			Long mno = Long.valueOf(request.getParameter("mno"));
			Comment dto = new Comment();
			dto.setC_b_no(Long.valueOf(request.getParameter("bno")));
			dto.setC_m_no(member.getM_no());
			dto.setC_name(member.getM_name());
			dto.setC_img(member.getM_img1());
			dto.setC_content(request.getParameter("content"));
			dto.setC_group(Long.valueOf(request.getParameter("cno")));
			dto.setC_parentFl(Boolean.valueOf(request.getParameter("parentFl")));
			
			commentService cs = new commentService();
			
			int process = 0;
			
			if(!dto.getC_parentFl()) {				
				process = cs.insert(dto);
			}else {
				process = cs.insertChild(dto);
			}
						
			if(process > 0) {
				response.sendRedirect("./list?no="+dto.getC_b_no()+"&mno="+mno);
			}else {
				String icon = "error", msg = "실패";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect(request.getHeader("referer"));
			}
			
			
		}
	}

}
