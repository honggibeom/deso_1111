package controller.admin.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.board.Board;
import service.admin.boardService;

@WebServlet(name = "adminBoardProcess", urlPatterns = { "/admin/board/process" })
public class process extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public process() {
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
			
			String mode = (String)request.getParameter("mode");
			String action = (String)request.getParameter("action");
			Board dto = new Board();
			dto.setB_no((request.getParameter("no")!=null)?Long.valueOf((String)request.getParameter("no")):0);
			dto.setB_kind(mode);
			dto.setB_m_no(null);
			dto.setB_m_id(admin.getAdmin_id());
			dto.setB_title((String)request.getParameter("title"));
			dto.setB_address((String)request.getParameter("addr"));
			dto.setB_address_sub((String)request.getParameter("addr2"));	
			dto.setB_address_X((String)request.getParameter("addrX"));
			dto.setB_address_Y((String)request.getParameter("addrY"));
			dto.setB_open_chatting_url((request.getParameter("open")!=null)?(String)request.getParameter("open"):"");
			dto.setB_category((String)request.getParameter("cate"));				
			dto.setB_p_limit((String)request.getParameter("limit"));
							
			String date = (String)request.getParameter("date");
			String Time = (String)request.getParameter("Time");
			String day = date+" "+Time+":00";
			dto.setB_time(Timestamp.valueOf(day));
//
			dto.setB_content((String)request.getParameter("content"));
			dto.setB_rule((String)request.getParameter("rule"));
			dto.setB_deadline_fl((request.getParameter("deadline") != null)?Boolean.valueOf((String)request.getParameter("deadline")):false);
			
			
			
			dto.setB_img1((request.getParameter("img1") != null && !request.getParameter("img1").equals(""))?(String)request.getParameter("img1"):"");
			dto.setB_img2((request.getParameter("img2") != null && !request.getParameter("img2").equals(""))?(String)request.getParameter("img2"):"");
			dto.setB_img3((request.getParameter("img3") != null && !request.getParameter("img3").equals(""))?(String)request.getParameter("img3"):"");
			dto.setB_img4((request.getParameter("img4") != null && !request.getParameter("img4").equals(""))?(String)request.getParameter("img4"):"");
											
			boardService bs = new boardService();
			
			Long chk = bs.process(dto,action);
			if(chk>0){
				if(action.equals("update")) {						
					out.println("<script>");
					out.println("alert('수정되었습니다.');");
					out.println("location.href='./view?mode="+mode+"&action="+action+"&no="+dto.getB_no()+"'");
					out.println("</script>");
				}else {
					out.println("<script>");
					out.println("alert('등록되었습니다.');");
					out.println("location.href='./list?mode="+mode+"'");
					out.println("</script>");
				}
			}else{
				out.println("<script>");
				out.println("alert('실패');");
				out.println("history.back();");
				out.println("</script>");
			}
								
			
						
		}

	}

}
