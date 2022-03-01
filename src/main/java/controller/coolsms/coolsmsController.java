package controller.coolsms;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.util.HashMap;
import java.util.Random;

import org.json.simple.JSONObject;
import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@WebServlet("/coolsms")
public class coolsmsController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	
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
		
		String msg = ((String)session.getAttribute("massage") != null)?(String)session.getAttribute("massage"):"";

		String tel = request.getParameter("tal");
		
		Random random = new Random();
	    int randomNumber = random.nextInt(888888) + 111111;
	    String massage = String.valueOf(randomNumber); 
		
		
		String api_key = "NCS1WLG6XY6MV1D8";
		String api_secret = "CYE6HZRLDSK326HOYJDFE0QIYKW620XJ";
		Message coolsms = new Message(api_key, api_secret);

		// 4 params(to, from, type, text) are mandatory. must be filled
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", tel);
		params.put("from", "01056225322"); 
		params.put("type", "SMS");
		params.put("text", "인증번호 : "+ massage);
		params.put("app_version", "test app 1.2"); // application name and version
		
		try {
		  JSONObject obj = (JSONObject) coolsms.send(params);
		  if(msg.equals("")) {
			 session.setAttribute("massage", massage); 
			 session.setMaxInactiveInterval(3*60);
		  }else{
			 session.removeAttribute("massage");
			 session.setAttribute("massage", massage);
			 session.setMaxInactiveInterval(3*60);
		  };	
		} catch (CoolsmsException e) {
		  System.out.println(e.getMessage());
		  System.out.println(e.getCode());
		}
		
	}


}
