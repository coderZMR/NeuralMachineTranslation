package cn.nmtweb.servlet;

import cn.nmtweb.bean.*;
import cn.nmtweb.service.*;
import cn.nmtweb.service.impl.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class QuestionHome extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        String opt = req.getParameter("opt");
        if ("add".equals(opt)) {
            Date day = new Date();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String curDay = df.format(day);
            HttpSession session = req.getSession();
            Question question = new Question();
            question.setUserName((String) session.getAttribute("userName"));
            question.setEnd(0);
            question.setaNum(0);
            question.setqString(req.getParameter("content"));
            question.setqDate(curDay);
            DoQuestionService doQuestionService = new DoQuestionServiceImpl();
            doQuestionService.addQinfo(question);
            UserInfoService userInfoService = new UserInfoServiceImpl();
            userInfoService.updateUserInfo("questionNum", (String) session.getAttribute("userName"));
            // 问题信息
            List<Question> qList = doQuestionService.getQinfo("All");
            req.setAttribute("qList", qList);
            req.getRequestDispatcher("questionHome.jsp").forward(req, resp);
        }
        else if ("detail".equals(opt)) {
            int qId = Integer.parseInt(req.getParameter("qId"));
            DoQuestionService doQuestionService = new DoQuestionServiceImpl();
            Question question = doQuestionService.getQuestionById(qId);
            DoAnswerService doAnswerService = new DoAnswerServiceImpl();
            List<Answer> aList = doAnswerService.getAinfoByqId(qId);
            req.setAttribute("question", question);
            req.setAttribute("aList", aList);
            req.getRequestDispatcher("detail.jsp" + "?" + "qId" + "=" + Integer.toString(qId)).forward(req, resp);
        }
        else if ("reply".equals(opt)) {
            Date day = new Date();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String curDay = df.format(day);
            int qId = Integer.parseInt(req.getParameter("qId"));
            HttpSession session = req.getSession();
            String qUserName = req.getParameter("qUserName");
            int aNum = Integer.parseInt(req.getParameter("aNum"));
            // 构建 Answer 实例
            Answer answer = new Answer();
            answer.setaString(req.getParameter("content"));
            answer.setqUserName(qUserName);
            answer.setaDate(curDay);
            answer.setaUserName((String) session.getAttribute("userName"));
            answer.setqId(qId);
            answer.setAccept(0);
            DoAnswerService doAnswerService = new DoAnswerServiceImpl();
            if(doAnswerService.addAnswer(answer)) {
                // 构建 Message 实例
                Message message = new Message();
                message.setqId(qId);
                message.setaId(doAnswerService.getMaxId());
                message.setqUserName(qUserName);
                message.setaUserName((String) session.getAttribute("userName"));
                message.setmDate(curDay);
                message.setqString(req.getParameter("qString"));
                message.setaString(req.getParameter("content"));
                message.setType(0);
                DoMessageService doMessageService = new DoMessageServiceImpl();
                doMessageService.addMessage(message);
                DoQuestionService doQuestionService = new DoQuestionServiceImpl();
                if (doQuestionService.UpdateQuestionById(qId, aNum)) {
                    UserInfoService userInfoService = new UserInfoServiceImpl();
                    userInfoService.updateUserInfo("answerNum", (String) session.getAttribute("userName"));
                    Question question = doQuestionService.getQuestionById(qId);
                    List<Answer> aList = doAnswerService.getAinfoByqId(qId);
                    req.setAttribute("question", question);
                    req.setAttribute("aList", aList);
                    req.getRequestDispatcher("detail.jsp" + "?" + "qId" + "=" + Integer.toString(qId)).forward(req, resp);
                }
            }
        }
        else if ("accept".equals(opt)) {
            Date day = new Date();
            SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String curDay = df.format(day);
            int qId = Integer.parseInt(req.getParameter("qId"));
            int aId = Integer.parseInt(req.getParameter("aId"));
            Message message = new Message();
            message.setqId(qId);
            message.setaId(aId);
            message.setqUserName(req.getParameter("qUserName"));
            message.setaUserName(req.getParameter("aUserName"));
            message.setmDate(curDay);
            message.setqString(req.getParameter("qString"));
            message.setaString(req.getParameter("aString"));
            message.setType(1);
            CorpusItem corpusItem = new CorpusItem();
            corpusItem.setqString(req.getParameter("qString"));
            corpusItem.setaString(req.getParameter("aString"));
            DoAnswerService doAnswerService = new DoAnswerServiceImpl();
            if (doAnswerService.updateAccept(aId)) {
                DoQuestionService doQuestionService = new DoQuestionServiceImpl();
                if (doQuestionService.UpdateEnd(qId)) {
                    DoMessageService doMessageService = new DoMessageServiceImpl();
                    if (doMessageService.addMessage(message)) {
                        DoCorpusService doCorpusService = new DoCorpusServiceImpl();
                        if (doCorpusService.addToCorpus(corpusItem)) {
                            UserInfoService userInfoService = new UserInfoServiceImpl();
                            userInfoService.updateUserInfo("acceptNum", req.getParameter("aUserName"));
                            Question question = doQuestionService.getQuestionById(qId);
                            List<Answer> aList = doAnswerService.getAinfoByqId(qId);
                            req.setAttribute("question", question);
                            req.setAttribute("aList", aList);
                            req.getRequestDispatcher("detail.jsp" + "?" + "qId" + "=" + Integer.toString(qId)).forward(req, resp);
                        }
                        else System.out.println("*******************************插入corpus_en_cn表信息失败");
                    }
                    else System.out.println("*******************************插入Message表信息失败");
                }
                else System.out.println("*******************************更新Question表End失败");
            }
            else System.out.println("*******************************更新Answer表Accept失败");
        }
        else {
            // 问题信息
            DoQuestionService doQuestionService = new DoQuestionServiceImpl();
            List<Question> qList = doQuestionService.getQinfo("All");
            req.setAttribute("qList", qList);
            req.getRequestDispatcher("questionHome.jsp").forward(req, resp);
        }
    }
}
