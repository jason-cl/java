package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class testServlet extends HttpServlet{
   
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String n=req.getParameter("name");System.out.println("old£º "+n);
		String nw = n.replaceAll("¡±","\"");
		String nw1=nw.replaceAll("¡°","\"");
		System.out.println(nw1);
		
	}
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		this.doPost(req, resp);
	}
}
