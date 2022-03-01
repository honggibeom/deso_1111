package controller.board;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.alert.Alert;
import dto.board.Board;
import dto.member.Member;
import service.board.boardService;


@WebServlet(name = "boardlist", urlPatterns = { "/board/list" })
public class list extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public list() {
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
		
		Member member = (Member)session.getAttribute("member");
		
		if(member==null){
			String icon = "error", msg = "회원전용 페이지입니다. 로그인해주세요.";
			Alert alert = new Alert(icon, msg);
			alert.save(request, alert);
			response.sendRedirect("../index");
		}else{
			
			if(session.getAttribute("referer") != null) {
				session.removeAttribute("referer");
			}
			
			String mode = request.getParameter("mode");
			String addr = (request.getParameter("addr") != null && !request.getParameter("addr").equals(""))?(String)request.getParameter("addr"):"";
			String locationX = (request.getParameter("locationX") != null && !request.getParameter("locationX").equals(""))?(String)request.getParameter("locationX"):"";
			String locationY = (request.getParameter("locationY") != null && !request.getParameter("locationY").equals(""))?(String)request.getParameter("locationY"):"";
			String cate = (request.getParameter("cate") != null && !request.getParameter("cate").equals(""))?(String)request.getParameter("cate"):"";
			String date = (request.getParameter("date") != null && !request.getParameter("date").equals(""))?(String)request.getParameter("date"):"";
			
			String date1 = "", date2 = "";
			
					
			if(date != null && !date.equals("")) {	
				if(date.indexOf("~") > 0) {
					String[] day = date.split("~");
					date1 = day[0]; date2 = day[1];
				}else {
					date1 = date; date2 = date;
				}
			}
				
			
			boardService ms = new boardService();
						
			List<Board> list = ms.boardList(mode,cate,date1,date2);
			
			List<Board> list2 = new ArrayList<Board>();
			
			String x = "", y = "";

			//검색필터 걸치지않았을때
			if(request.getParameter("addr") != null && !request.getParameter("addr").equals("")) {
				x = locationX;
				y = locationY;			
			}else {
				x = member.getM_locationX() != null ? member.getM_locationX() : "36.80092678578682";
				y = member.getM_locationY() != null ? member.getM_locationY() : "127.12313387583411";
			}	
			
			
			if(list.size()>0 && x != null && y != null) {
				for(int i=0; i<list.size(); i++) {
					// 킬로미터(Kilo Meter) 단위
					if(list.get(i).getB_address_X() != null && !list.get(i).getB_address_X().equals("")) {
						
						double distanceKiloMeter = distance(Double.parseDouble(x), Double.parseDouble(y),
								Double.parseDouble(list.get(i).getB_address_X()), Double.parseDouble(list.get(i).getB_address_Y()), "kilometer");
						int distance = (int)distanceKiloMeter;
						if(distance <= 3) {
							list2.add(list.get(i));
						}
					}
					
				}
				request.setAttribute("list", list2);
			}else {
				request.setAttribute("list", list);
			}
			
			request.setAttribute("x", x);
			request.setAttribute("y", y);
			request.setAttribute("addr", addr);
			request.setAttribute("cate", cate);
			request.setAttribute("date", date);
			request.setAttribute("mode", mode);
			
			RequestDispatcher dis = request.getRequestDispatcher("./list.jsp");
			dis.forward(request, response);
		}
	}
	
	
    private static double distance(double lat1, double lon1, double lat2, double lon2, String unit) {
        
        double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
         
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515;
         
        if (unit == "kilometer") {
            dist = dist * 1.609344;
        }
 
        return (dist);
    }
     
 
    // This function converts decimal degrees to radians
    private static double deg2rad(double deg) {
        return (deg * Math.PI / 180.0);
    }
     
    // This function converts radians to decimal degrees
    private static double rad2deg(double rad) {
        return (rad * 180 / Math.PI);
    }



}
