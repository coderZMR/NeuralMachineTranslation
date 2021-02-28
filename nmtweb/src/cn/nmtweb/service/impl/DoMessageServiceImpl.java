package cn.nmtweb.service.impl;

import cn.nmtweb.bean.Message;
import cn.nmtweb.dao.DoCorpusDao;
import cn.nmtweb.dao.DoMessageDao;
import cn.nmtweb.dao.impl.DoMessageDaoImpl;
import cn.nmtweb.service.DoMessageService;

import java.util.List;

public class DoMessageServiceImpl implements DoMessageService {
    @Override
    public boolean addMessage(Message message) {
        DoMessageDao doMessageDao = new DoMessageDaoImpl();
        return doMessageDao.addMessage(message);
    }

    @Override
    public List<Message> getMessageList(String userName) {
        DoMessageDao doMessageDao = new DoMessageDaoImpl();
        return doMessageDao.getMessageList(userName);
    }

    @Override
    public boolean deleteAll(String userName) {
        DoMessageDao doMessageDao = new DoMessageDaoImpl();
        return doMessageDao.deleteAll(userName);
    }

    @Override
    public boolean delete(int mId) {
        DoMessageDao doMessageDao = new DoMessageDaoImpl();
        return doMessageDao.delete(mId);
    }
}
