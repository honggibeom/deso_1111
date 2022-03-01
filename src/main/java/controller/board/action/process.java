package controller.board.action;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.board.Board;
import dto.member.Member;
import service.board.boardService;

@WebServlet(name = "boardProcess", urlPatterns = { "/board/process" })
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
		
		HttpSession session = request.getSession();
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../index");
		}else{					
			String mode = (String)request.getParameter("mode");
			Board dto = new Board();
			dto.setB_no((request.getParameter("no")!=null)?Long.valueOf((String)request.getParameter("no")):0);
			dto.setB_kind("모임");
			dto.setB_m_no(member.getM_no());
			dto.setB_m_id(member.getM_id());
			dto.setB_title((String)request.getParameter("title"));
			dto.setB_address((String)request.getParameter("addr"));
			dto.setB_address_sub((String)request.getParameter("addr2"));	
			dto.setB_address_X((String)request.getParameter("addrX"));
			dto.setB_address_Y((String)request.getParameter("addrY"));
			dto.setB_open_chatting_url((request.getParameter("open")!=null)?(String)request.getParameter("open"):"");
			dto.setB_category((String)request.getParameter("cate"));				
			dto.setB_p_limit((String)request.getParameter("limit"));
							
			String date = (String)request.getParameter("date");				
			String hour = (String)request.getParameter("mHour");
			String min = (String)request.getParameter("mMinute");				
			String day = date+" "+hour+":"+min+":00";			
			dto.setB_time(Timestamp.valueOf(day));
			
			dto.setB_content((String)request.getParameter("content"));
			dto.setB_rule((String)request.getParameter("rule"));
			dto.setB_deadline_fl((request.getParameter("deadline") != null)?Boolean.valueOf((String)request.getParameter("deadline")):false);
			
			
			dto.setB_img1((request.getParameter("img1") != null && !request.getParameter("img1").equals(""))?(String)request.getParameter("img1"):null);
			dto.setB_img2((request.getParameter("img2") != null && !request.getParameter("img2").equals(""))?(String)request.getParameter("img2"):null);
			dto.setB_img3((request.getParameter("img3") != null && !request.getParameter("img3").equals(""))?(String)request.getParameter("img3"):null);
			dto.setB_img4((request.getParameter("img4") != null && !request.getParameter("img4").equals(""))?(String)request.getParameter("img4"):null);
			
			boardService bs = new boardService();
			
			Long no = bs.process(dto,mode);
			
			String page = "모임";

			if(no>0){
				if(mode.equals("new")) {						
					String icon = "success", msg = "등록되었습니다.";
					Alert alert = new Alert(icon, msg);
					alert.save(request, alert);
					response.sendRedirect("./view?no="+no+"&referer=board/list?mode="+URLEncoder.encode(page));
				}else {
					String icon = "success", msg = "수정되었습니다.";
					Alert alert = new Alert(icon, msg);
					alert.save(request, alert);
					response.sendRedirect("./view?no="+dto.getB_no());
				}
			}else{
				String icon = "error", msg = "실패하였습니다.";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect(request.getHeader("referer"));
			}				
			
		}	
	}

}
