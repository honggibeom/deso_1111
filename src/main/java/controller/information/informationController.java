package controller.information;

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
 * Servlet implementation class serviceController
 */
@WebServlet("/information/terms")
public class informationController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public informationController() {
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
		
		String title = request.getParameter("title");
		
		imformationService ifm = new imformationService();
		
		List<Information> list = ifm.list(); 
		
		request.setAttribute("list", list);
		request.setAttribute("title", title);
		
		RequestDispatcher dis = request.getRequestDispatcher("../service/terms/terms.jsp");
		dis.forward(request, response);
		
	}

}
