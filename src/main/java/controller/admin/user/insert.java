package controller.admin.user;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.member.Member;
import service.admin.userService;

/**
 * Servlet implementation class insert
 */
@WebServlet("/admin/user/insert")
public class insert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public insert() {
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

		HttpSession session = request.getSession();
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		if(admin==null){
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('관리자 전용 페이지 입니다.');");
			out.println("location.href='../home'");
			out.println("</script>");
		}else{				
			Member dto = new Member();

			dto.setM_id(request.getParameter("id"));
			dto.setM_pw(request.getParameter("pw"));
			dto.setM_name(request.getParameter("name"));
			dto.setM_school(request.getParameter("school"));
			dto.setM_study(request.getParameter("study"));
			dto.setM_birth(request.getParameter("birthdate"));
			dto.setM_phone(request.getParameter("phone"));
										
			userService us = new userService();

			int chk = us.memberInsert(dto);

			PrintWriter out = response.getWriter();

			out.println("<script>");
			
			if(chk == 0){
				out.println("alert('실패');");
				out.println("history.back();");
			}else if(chk == 1) {
				out.println("alert('이미 존재한 아이디입니다.');");
				out.println("history.back();");
			}else if(chk == 2) {
				out.println("alert('이미 존재한 휴대폰 번호입니다.');");
				out.println("history.back();");
			}else{
				out.println("alert('등록되었습니다.');");
				out.println("location.href='./insertHome';");
			}
			
			out.println("</script>");
			
		}
		
	}

}
