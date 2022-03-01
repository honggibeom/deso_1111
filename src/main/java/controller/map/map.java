package controller.map;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/map")
public class map extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public map() {
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
		
		
		// 요청변수 설정
    	String currentPage = "1";    //요청 변수 설정 (현재 페이지. currentPage : n > 0)
		String countPerPage = "100";  //요청 변수 설정 (페이지당 출력 개수. countPerPage 범위 : 0 < n <= 100)
		String resultType = "json";      //요청 변수 설정 (검색결과형식 설정, json)
		String confmKey = "U01TX0FVVEgyMDIxMTEyODIyMjg0MDExMTk2Mzc=";          //요청 변수 설정 (승인키)
		String keyword = request.getParameter("keyword");            //요청 변수 설정 (키워드)
		String keyword2 = (request.getParameter("keyword2") != null)?request.getParameter("keyword2"):null;            //요청 변수 설정 (키워드)
		if(keyword2 != null) {
			keyword = keyword2 + keyword;
		}
		
		// OPEN API 호출 URL 정보 설정
		String apiUrl = "https://www.juso.go.kr/addrlink/addrLinkApi.do?currentPage="+currentPage+"&countPerPage="+countPerPage+"&keyword="+URLEncoder.encode(keyword,"UTF-8")+"&confmKey="+confmKey+"&resultType="+resultType;
		URL url = new URL(apiUrl);
    	BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(),"UTF-8"));
    	StringBuffer sb = new StringBuffer();
    	String tempStr = null;
    	
    	while(true){
    		tempStr = br.readLine();
    		if(tempStr == null) break;		
    		sb.append(tempStr);								// 응답결과 JSON 저장
    	}

    	br.close();
    	response.setCharacterEncoding("UTF-8");
		response.setContentType("text/xml");
		response.getWriter().write(sb.toString());			// 응답결과 반환
	}

}
