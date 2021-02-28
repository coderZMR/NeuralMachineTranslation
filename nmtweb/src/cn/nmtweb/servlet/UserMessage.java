package cn.nmtweb.servlet;

import cn.nmtweb.bean.Message;
import cn.nmtweb.service.DoMessageService;
import cn.nmtweb.service.impl.DoMessageServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class UserMessage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        DoMessageService doMessageService = new DoMessageServiceImpl();
        HttpSession session = req.getSession();
        String userName = (String) session.getAttribute("userName");
        if ("deleteAll".equals(req.getParameter("opt"))) {
            doMessageService.deleteAll(userName);
        }
        else if ("delete".equals(req.getParameter("opt"))) {
            doMessageService.delete(Integer.parseInt(req.getParameter("mId")));
        }
        List<Message> messageList = doMessageService.getMessageList(userName);
        req.setAttribute("messageList", messageList);
        req.getRequestDispatcher("message.jsp").forward(req, resp);
    }
}
