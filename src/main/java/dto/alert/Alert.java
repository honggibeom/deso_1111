package dto.alert;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class Alert {
	private String icon;
	private String msg;
	
	public Alert(String icon, String msg) {
		this.icon = icon;
		this.msg = msg;
	}
	
	public void save(HttpServletRequest request, Alert alert) {
		HttpSession session = request.getSession();
		session.setAttribute("alert", alert);
	}

	public String getIcon() {
		return icon;
	}

	public String getMsg() {
		return msg;
	}


	
	
	
	
}
