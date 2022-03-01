package controller.admin.terms;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.information.Information;
import service.information.imformationService;

@WebServlet(name = "adminTermsProcess", urlPatterns = { "/admin/terms/process" })
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
		
		Admin admin = (Admin)session.getAttribute("admin");
		
		if(admin==null){
			PrintWriter out = response.getWriter();
			
			out.println("<script>");
			out.println("alert('관리자 전용 페이지 입니다.');");
			out.println("location.href='../home'");
			out.println("</script>");
		}else{
			
			String mode = request.getParameter("mode");
			
			Information info = new Information(); 			
			info.setI_no((request.getParameter("no") != null)?Long.valueOf(request.getParameter("no")):0L);
			info.setI_id(admin.getAdmin_id());
			info.setI_title(request.getParameter("title"));
			info.setI_content(request.getParameter("content"));
			
			imformationService ifm = new imformationService();
			
			ifm.process(info,mode); 
			
			response.sendRedirect("./list");
		}
	}

}
