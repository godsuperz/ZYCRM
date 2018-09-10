package com.zhiyou100.crm.servlet.message;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.zhiyou100.crm.model.Message;
import com.zhiyou100.crm.service.MessageService;
import com.zhiyou100.crm.service.impl.MessageServiceImpl;
import com.zhiyou100.crm.util.AdminBaseServlet;

@WebServlet(urlPatterns = { "/message/save" })
public class SaveServlet extends AdminBaseServlet {
	private static final long serialVersionUID = 1L;
	
	MessageService messageService = new MessageServiceImpl();
       
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/message/save.jsp").forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Message message = new Message();
		
		message.setSubject(request.getParameter("subject"));
		message.setContent(request.getParameter("content"));
		message.setSender(user.getUserId());
		message.setReceiver(Integer.parseInt(request.getParameter("receiver")));
		message.setSaveTime(Timestamp.valueOf(LocalDateTime.now()));
		message.setSendTime(Timestamp.valueOf(LocalDateTime.now()));
		
		System.out.println(message);
		
		// 注意这里判断用户点哪个按扭的方法！
		boolean send = request.getParameter("send") != null;
		
		if (messageService.save(message, send)) {
			if(send) {
				response.sendRedirect(request.getContextPath() + "/message/listSend");
			}
			else {
				response.sendRedirect(request.getContextPath() + "/message/listSave");
			}
		}
		else{
			doGet(request, response);
		}
		
	}

}
