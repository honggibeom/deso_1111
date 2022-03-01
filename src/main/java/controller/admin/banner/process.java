package controller.admin.banner;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import dto.admin.Admin;
import dto.banner.Banner;
import service.banner.bannerService;

@WebServlet(name = "bannerProcess", urlPatterns = { "/admin/banner/process" })
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
			
			Banner dto = new Banner();
			String mode = (String)request.getParameter("mode");
			dto.setImg1((request.getParameter("img1") != null)?(String)request.getParameter("img1"):null);
			dto.setImg2((request.getParameter("img2") != null)?(String)request.getParameter("img2"):null);
			dto.setImg3((request.getParameter("img3") != null)?(String)request.getParameter("img3"):null);
							
			bannerService us = new bannerService();
			
			int chk = us.process(dto,mode);
							
			if(chk>0){
				response.sendRedirect("./success");
			}else{
				PrintWriter out = response.getWriter();
				out.println("<script>");
				out.println("alert('실패');");
				out.println("history.back();");
				out.println("</script>");
			}
								
			
						
		}
			
	}

}
