package cn.nmtweb.service.impl;

import cn.nmtweb.bean.Answer;
import cn.nmtweb.dao.DoAnswerDao;
import cn.nmtweb.dao.impl.DoAnswerDaoImpl;
import cn.nmtweb.service.DoAnswerService;

import java.util.List;

public class DoAnswerServiceImpl implements DoAnswerService {
    @Override
    public List<Answer> getAinfo(String userName) {
        DoAnswerDao doAnswerDao = new DoAnswerDaoImpl();
        return doAnswerDao.getAinfo(userName);
    }

    @Override
    public List<Answer> getAinfoByqId(int qId) {
        DoAnswerDao doAnswerDao = new DoAnswerDaoImpl();
        return doAnswerDao.getAinfoByqId(qId);
    }

    @Override
    public boolean addAnswer(Answer answer) {
        DoAnswerDao doAnswerDao = new DoAnswerDaoImpl();
        return doAnswerDao.addAnswer(answer);
    }

    @Override
    public int getMaxId() {
        DoAnswerDao doAnswerDao = new DoAnswerDaoImpl();
        return doAnswerDao.getMaxId();
    }

    @Override
    public boolean updateAccept(int aId) {
        DoAnswerDao doAnswerDao = new DoAnswerDaoImpl();
        return doAnswerDao.updateAccept(aId);
    }
}
