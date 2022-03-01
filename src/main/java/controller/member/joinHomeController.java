package controller.member;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dto.information.Information;
import service.information.imformationService;

/**
 * Servlet implementation class joinHomeController
 */
@WebServlet("/joinHome")
public class joinHomeController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public joinHomeController() {
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
		imformationService is = new imformationService();
		
		Information use = is.getInformation(Long.valueOf(1));
		Information privacy  = is.getInformation(Long.valueOf(2));
		Information gps = is.getInformation(Long.valueOf(3));
		
		request.setAttribute("use", use);
		request.setAttribute("privacy", privacy);
		request.setAttribute("gps", gps);
		
		RequestDispatcher dis = request.getRequestDispatcher("./account/join.jsp");
		dis.forward(request, response);
	}

}
