package controller.admin.report;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.admin.Admin;
import dto.page.pageDTO;
import dto.report.Report;
import service.admin.reportService;


@WebServlet(name = "reportListController", urlPatterns = { "/admin/report/list" })
public class list extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public list() {
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
			
			reportService rs = new reportService();
			
			String kind = (request.getParameter("kind") != null && request.getParameter("kind") != "")?request.getParameter("kind"):"";
			String keyword = (request.getParameter("keyword") != null && request.getParameter("keyword") != "")?request.getParameter("keyword"):"";
			
			// page 작업
			int page = 1; // 페이지 순번
			int page1 = 0;
			int page2 = 0;
			
			// null 값이 들어가면 오류가 뜨는 것을 방지하기 위해서 page1과 page2를 만들었음.
			if(request.getAttribute("paging")!=null) {
				page1 = (int)request.getAttribute("paging");
			}
			if(request.getParameter("page") != null && request.getParameter("page")!="") {
				page2 = Integer.parseInt(request.getParameter("page"));
			}
			
			int limit = 10; // 하나의 페이지 안에 몇개의 글이 있는지
			
			
			// page1이나 page2가 null이 아닐 경우에 page에 값을 입력해주는 작업.
			if (page2 != 0) {
				page = page2;
			} else if (page1 != 0) {
				page = page1;
			}
			
			// limit 값을 걸어놓은 만큼 범위에 해당하는 글만 가져오는 방법
			int startRow = (page - 1) * limit;
			int endRow = limit;

			//상품리스트
			String sort = request.getParameter("sort");
			List<Report> list = rs.list(sort,kind,keyword,startRow,endRow);
			
			// 전체 게시글 가져오기 위한 ( 전체 글 개수 세는 것)
			int listCount = rs.listCount(sort,kind,keyword,startRow,endRow);
			
			// 최대로 필요한 페이지 개수 계산
			int maxPage = (int) ((double) listCount / limit + 0.9); // 끝 페이지를 계산하기 위해서 필요한 코드
			
			// 현재 페이지에 보여줄 시작페이지
			int startPage = (((int) ((double) page / 10 + 0.9)) - 1) * 10 + 1; // => 1, 11, 21, 31, 41, . . . .
			
			// 현재 페이지에 보여줄 끝페이지
			int endPage = startPage + 10 - 1; // => 10, 20, 30, 40, . . . .
			
			if (endPage > maxPage) {
				endPage = maxPage;
			}
			
			pageDTO paging = new pageDTO();
			paging.setEndPage(endPage);
			paging.setListCount(listCount);
			paging.setMaxPage(maxPage);
			paging.setPage(page);
			paging.setStartPage(startPage);
			paging.setEndRow(endRow);
			
			
			request.setAttribute("kind", kind);
			request.setAttribute("keyword", keyword);
			request.setAttribute("list", list);
			request.setAttribute("paging", paging);
			request.setAttribute("sort", sort);

			
			RequestDispatcher dis = request.getRequestDispatcher("./list.jsp");
			dis.forward(request, response);	
		}
		
	}

}
