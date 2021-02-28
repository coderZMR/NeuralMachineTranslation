package cn.nmtweb.service.impl;

import cn.nmtweb.bean.Question;
import cn.nmtweb.dao.DoQuestionDao;
import cn.nmtweb.dao.impl.DoQuestionDaoImpl;
import cn.nmtweb.service.DoQuestionService;

import java.util.List;

public class DoQuestionServiceImpl implements DoQuestionService {
    @Override
    public List<Question> getQinfo(String userName) {
        DoQuestionDao doQuestionDao = new DoQuestionDaoImpl();
        return doQuestionDao.getQinfo(userName);
    }

    @Override
    public boolean addQinfo(Question question) {
        DoQuestionDao doQuestionDao = new DoQuestionDaoImpl();
        return doQuestionDao.addQinfo(question);
    }

    @Override
    public Question getQuestionById(int qId) {
        DoQuestionDao doQuestionDao = new DoQuestionDaoImpl();
        return doQuestionDao.getQuestionById(qId);
    }

    @Override
    public boolean UpdateQuestionById(int qId, int aNum) {
        DoQuestionDao doQuestionDao = new DoQuestionDaoImpl();
        return doQuestionDao.UpdateQuestionById(qId, aNum);
    }

    @Override
    public boolean UpdateEnd(int qId) {
        DoQuestionDao doQuestionDao = new DoQuestionDaoImpl();
        return doQuestionDao.UpdateEnd(qId);
    }

}
