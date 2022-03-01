package controller.board;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.List;


import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import dto.alert.Alert;
import dto.board.Board;
import dto.member.Member;
import service.board.boardService;
import service.member.memberService;

@WebServlet(name = "boardMapView", urlPatterns = { "/board/mapView" })
public class mapView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public mapView() {
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
		PrintWriter out = response.getWriter();		
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../index");
		}else{
			boardService bs = new boardService();
			memberService ms = new memberService();
			
			Long no = (request.getParameter("no")!=null)?Long.valueOf(request.getParameter("no")):0L;
			SimpleDateFormat date = new SimpleDateFormat("MM-dd HH:mm");
			Board b = bs.getBoard(no);
	
			
			JSONArray arr = new JSONArray();
			JSONObject obj = new JSONObject();
			obj.put("no",b.getB_no());
			obj.put("mno", b.getB_m_no());
			obj.put("category",b.getB_category());
			obj.put("address",b.getB_address_sub());
			obj.put("time", date.format(b.getB_time()));
			obj.put("title",b.getB_title());
			obj.put("limit",b.getB_p_limit());
			obj.put("count",Integer.toString(b.getB_p_count()));
			obj.put("img",b.getB_img1());
			
			arr.add(obj);
			String jsonInfo = arr.toJSONString(); 
			out.print(jsonInfo);	
		}
	}

}
