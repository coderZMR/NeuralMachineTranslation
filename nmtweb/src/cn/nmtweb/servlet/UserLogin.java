package cn.nmtweb.servlet;

import cn.nmtweb.bean.User;
import cn.nmtweb.service.UserLoginService;
import cn.nmtweb.service.impl.UserLoginServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


public class UserLogin extends HttpServlet {
    private UserLoginService userLoginService = new UserLoginServiceImpl();
    private User user = new User();
    public void doGet(HttpServletRequest request,
                      HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
    public void doPost(HttpServletRequest request,
                      HttpServletResponse response) throws ServletException, IOException {
        user.setUserName(request.getParameter("userName"));
        user.setPassword(request.getParameter("password"));
        if (userLoginService.userLogin(user)) {
            if ("admin".equals(user.getUserName())) {
                request.getRequestDispatcher("SysManage?target=SysMon").forward(request, response);
            }
            else {
                HttpSession session = request.getSession();
                session.setAttribute("userName", user.getUserName());
                session.setAttribute("password", user.getPassword());
                if ("add".equals(request.getParameter("from"))) request.getRequestDispatcher("/add.jsp").forward(request, response);
                else if ("detail".equals(request.getParameter("from"))) {
                    request.getRequestDispatcher("/QuestionHome?opt=detail&qId=" + request.getParameter("qId")).forward(request, response);
                }
                else if ("questionHome".equals(request.getParameter("from"))) {
                    request.getRequestDispatcher("QuestionHome").forward(request, response);
                }
                else request.getRequestDispatcher("/UserInfo?op=get&fromPage=userHome").forward(request, response);
            }
        }
        else {
            response.sendRedirect("login.jsp?info=error");
        }
    }
}
