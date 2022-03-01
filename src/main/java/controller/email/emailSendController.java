package controller.email;

import java.util.Properties;
import java.util.Random;
import java.io.IOException;

import javax.mail.Message;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/mailSend")
public class emailSendController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public emailSendController() {
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
		
		HttpSession sessionScope = request.getSession();
		
		String scope = ((String)sessionScope.getAttribute("email") != null)?(String)sessionScope.getAttribute("email"):"";
		
		// mail server 
		String host = "smtp.gmail.com";
		String user = "noreply@oddhem.com";  
		String password = "hfksexwvolkqqupc"; 
		
			
		String email = request.getParameter("mail");
		Random random = new Random();
	    int randomNumber = random.nextInt(888888) + 111111;
	    String massage = String.valueOf(randomNumber); 

		
		// SMTP
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 465);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		props.put("mail.smtp.starttls.enable","true");
	    props.put("mail.smtp.ssl.protocols", "TLSv1.2");
	    props.put("mail.smtp.socketFactory.fallback", "true");
				
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(user, password);
			}
		});
		

		// email
		try {	
			MimeMessage msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(user));

			msg.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
			
			msg.setSubject("데소 인증번호입니다.","UTF-8");
			
			msg.setText("인증번호 : " + massage,"UTF-8");
			
			if(scope.equals("")) {
				 sessionScope.setAttribute("email", massage); 
				 sessionScope.setMaxInactiveInterval(3*60);
			  }else{
				 sessionScope.removeAttribute("email");
				 sessionScope.setAttribute("email", massage);
				 sessionScope.setMaxInactiveInterval(3*60);
			  };
			
			Transport.send(msg);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	
		
	}
		
}
