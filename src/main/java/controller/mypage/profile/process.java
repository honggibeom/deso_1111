package controller.mypage.profile;


import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.member.Member;
import service.member.memberService;


@WebServlet(name = "mypageProfileProcess", urlPatterns = { "/mypage/profile/process" })
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
		memberService ms = new memberService();
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../../index");
		}else{									
			
			Member dto = new Member();
			dto.setM_no(member.getM_no());
			dto.setM_name((String)request.getParameter("name"));
			dto.setM_address((String)request.getParameter("addr"));
			dto.setM_locationX((String)request.getParameter("locationX"));
			dto.setM_locationY((String)request.getParameter("locationY"));
			dto.setM_about_me((request.getParameter("intro")!=null)?(String)request.getParameter("intro"):"");
			dto.setM_img1((request.getParameter("img1") != null)?(String)request.getParameter("img1"):null);
			dto.setM_img2((request.getParameter("img2") != null)?(String)request.getParameter("img2"):null);
			dto.setM_img3((request.getParameter("img3") != null)?(String)request.getParameter("img3"):null);
			dto.setM_img4((request.getParameter("img4") != null)?(String)request.getParameter("img4"):null);

				
			int chk = ms.modify(dto);
								
			if(chk>0){		
				Member m = ms.getMember(member.getM_no());				
				session.removeAttribute("member");
				session.setAttribute("member", m);			
				
				String icon = "success", msg = "수정되었습니다.";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect("../../mypage");
			}else{					
				String icon = "error", msg = "실패하였습니다.";
				Alert alert = new Alert(icon, msg);
				alert.save(request, alert);
				response.sendRedirect("../../mypage");
			}
					
		}
	}
	
}
