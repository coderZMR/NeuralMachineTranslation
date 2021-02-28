package cn.nmtweb.dao;

import cn.nmtweb.bean.Question;

import java.util.List;

public interface DoQuestionDao {
    public List<Question> getQinfo(String userName);
    public boolean addQinfo(Question question);
    public Question getQuestionById(int qId);
    public boolean UpdateQuestionById(int qId, int aNum);
    public boolean UpdateEnd(int qId);
}
