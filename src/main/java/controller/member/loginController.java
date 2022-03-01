package controller.member;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.member.Member;
import service.member.memberService;

/**
 * Servlet implementation class joinController
 */
@WebServlet("/login")
public class loginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public loginController() {
        super();
        // TODO Auto-generated constructor stub
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
		
		memberService ms = new memberService();
		
		Cookie[] cookies = request.getCookies();
		
		HttpSession session = request.getSession();
			
		Member m = new Member();
		
		HashMap<String,String> map = new HashMap<String,String>();
		
		if(session.getAttribute("member") != null) {
			session.removeAttribute("member");
		}
		
		
		if(cookies != null){
			
		    for(int i=0; i < cookies.length; i++){
		        Cookie c = cookies[i] ;
		        
		        String name = c.getName();
		        String val = c.getValue();
		        map.put(name,val);
		    }	

		}
		
		if(map.get("cookieId") != null && !map.get("cookieId").equals("")){		
			
			m = ms.cookidLogin(map.get("cookieId"));
			
		}else {			
			
			String id = request.getParameter("userId");
			String pw = request.getParameter("userPw");
					
			m = ms.memberLogin(id,pw);
			if(m != null) {				
				Cookie c = new Cookie("cookieId", m.getM_id());
				c.setMaxAge(60*60*24*90);
				response.addCookie(c);
			}
			
		}	
				
		
		
		if(m!=null){					
			session.setAttribute("member", m);				
			response.sendRedirect("./main");			
		}else{
			String icon = "error", msg = "아이디와 패스워드가 일치하지 않습니다.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			
			response.sendRedirect("./index");
		}
		
	}

}
