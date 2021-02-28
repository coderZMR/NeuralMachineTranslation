package cn.nmtweb.servlet;

import cn.nmtweb.bean.User;
import cn.nmtweb.service.UserRegisterService;
import cn.nmtweb.service.impl.UserRegisterServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class UserRegister extends HttpServlet{
    private UserRegisterService userRegisterService = new UserRegisterServiceImpl();
    private User user = new User();
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    public void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {
        user.setUserName(request.getParameter("userName"));
        user.setPassword(request.getParameter("password"));
        request.setAttribute("ifRegister", false);
        if (userRegisterService.userRegister(user)) {
            request.setAttribute("ifRegister", true);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
}
