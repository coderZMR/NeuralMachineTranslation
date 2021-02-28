package cn.nmtweb.dao;

import cn.nmtweb.bean.Answer;

import java.util.List;

public interface DoAnswerDao {
    public List<Answer> getAinfo(String userName);
    public List<Answer> getAinfoByqId(int qId);
    public boolean addAnswer(Answer answer);
    public int getMaxId();
    public boolean updateAccept(int aId);
}
