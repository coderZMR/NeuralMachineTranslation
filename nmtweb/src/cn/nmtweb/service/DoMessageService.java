package cn.nmtweb.service;

import cn.nmtweb.bean.Message;

import java.util.List;

public interface DoMessageService {
    public boolean addMessage(Message message);
    public List<Message> getMessageList(String userName);
    public  boolean deleteAll(String userName);
    public boolean delete(int mId);
}
