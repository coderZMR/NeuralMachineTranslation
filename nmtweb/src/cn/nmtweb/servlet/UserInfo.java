package cn.nmtweb.servlet;

import cn.nmtweb.bean.Answer;
import cn.nmtweb.bean.Question;
import cn.nmtweb.bean.User;
import cn.nmtweb.service.DoAnswerService;
import cn.nmtweb.service.DoQuestionService;
import cn.nmtweb.service.UserInfoService;
import cn.nmtweb.service.impl.DoAnswerServiceImpl;
import cn.nmtweb.service.impl.DoQuestionServiceImpl;
import cn.nmtweb.service.impl.UserInfoServiceImpl;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;


public class UserInfo extends HttpServlet {

    private void getInfo(HttpServletRequest req, UserInfoService userInfoService, HttpSession session) {
        // 用户信息
        User user = userInfoService.getUserInfo((String)session.getAttribute("userName"), (String)session.getAttribute("password"));
        req.setAttribute("user", user);
        // 问题信息
        DoQuestionService doQuestionService = new DoQuestionServiceImpl();
        List<Question> qList = doQuestionService.getQinfo((String) session.getAttribute("userName"));
        req.setAttribute("qList", qList);
        // 回答信息
        DoAnswerService doAnswerService = new DoAnswerServiceImpl();
        List<Answer> aList = doAnswerService.getAinfo((String) session.getAttribute("userName"));
        req.setAttribute("aList", aList);
    }

    private void getInfo(HttpServletRequest req, UserInfoService userInfoService, String userName) {
        // 用户信息
        User user = userInfoService.getUserInfo(userName, null);
        req.setAttribute("user", user);
        // 问题信息
        DoQuestionService doQuestionService = new DoQuestionServiceImpl();
        List<Question> qList = doQuestionService.getQinfo(userName);
        req.setAttribute("qList", qList);
        // 回答信息
        DoAnswerService doAnswerService = new DoAnswerServiceImpl();
        List<Answer> aList = doAnswerService.getAinfo(userName);
        req.setAttribute("aList", aList);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        HttpSession session = req.getSession();
        UserInfoService userInfoService = new UserInfoServiceImpl();
        if ("get".equals(req.getParameter("op"))) {
            // 取值
            if (null == (req.getParameter("toUserName"))) getInfo(req, userInfoService, session);
            else getInfo(req, userInfoService, req.getParameter("toUserName"));
            // 跳转
            String fromPage = req.getParameter("fromPage");
            req.getRequestDispatcher("/" + fromPage + ".jsp").forward(req, resp);
        } else {
            User user = new User();
            user.setUserName((String)session.getAttribute("userName"));
            user.setEmail(req.getParameter("email"));
            if (req.getParameter("sex").equals("0")) user.setSex("男");
            else user.setSex("女");
            user.setComeFrom(req.getParameter("city"));
            user.setSignature(req.getParameter("sign"));
            if (userInfoService.setUserInfo(user)) {
                getInfo(req, userInfoService, session);
                req.getRequestDispatcher("/home.jsp").forward(req, resp);
            } else {
                getInfo(req, userInfoService, session);
                req.getRequestDispatcher("/set.jsp").forward(req, resp);
            }
        }
    }
}
