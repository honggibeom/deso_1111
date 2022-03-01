package controller.admin.board.comment;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dto.admin.Admin;
import dto.comment.Comment;
import service.board.boardService;
import service.board.comment.commentService;

/**
 * Servlet implementation class list
 */
@WebServlet(name = "AdminCommentList", urlPatterns = { "/admin/comment" })
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
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		if(admin==null){
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('관리자 전용 페이지 입니다.');");
			out.println("location.href='../home'");
			out.println("</script>");
		}else{
			Long no = (request.getParameter("no") != null)?Long.valueOf(request.getParameter("no")):0L;
			boardService bs = new boardService();
			
			List<Comment> list = bs.getComment(no);
			SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");
						
			
			JSONArray arr = new JSONArray();
			for(int i=0; i<list.size(); i++) {
				JSONObject obj = new JSONObject();
				obj.put("no",list.get(i).getC_no());
				obj.put("content",list.get(i).getC_content());
				obj.put("mno",list.get(i).getC_m_no());
				obj.put("date",date.format(list.get(i).getRegDt()));
				arr.add(obj);
			}
	       
			String jsonInfo = arr.toJSONString();
			
	       	PrintWriter out = response.getWriter();
		   	out.print(jsonInfo);		
		
		}
		
	}

}
