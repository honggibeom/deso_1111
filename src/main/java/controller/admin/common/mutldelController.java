package controller.admin.common;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.admin.adminService;


/**
 * Servlet implementation class mutldelController
 */
@WebServlet("/admin/mutldel")
public class mutldelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public mutldelController() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(req, resp);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doProcess(req, resp);
	}

	protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		
		adminService as = new adminService();
		
		String mode = request.getParameter("mode");		
		String[] sno = request.getParameterValues("sno");
		
		int del = 0;
		for(int i = 0; i <sno.length; i++) {
			int no = Integer.parseInt(sno[i]);
			del = as.mutlDel(mode,no);
		}
		
		PrintWriter out = response.getWriter();
		int msg = 0;
		if(del > 0) {
			msg = 1;
		}else {
			msg = 0;
		}
		
		out.print(msg);	
	}

}
