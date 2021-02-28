package cn.nmtweb.dao;

import cn.nmtweb.bean.Message;

import java.util.List;

public interface DoMessageDao {
    public boolean addMessage(Message message);
    public List<Message> getMessageList(String userName);
    public boolean deleteAll(String userName);
    public boolean delete(int mId);
}
