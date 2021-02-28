package cn.nmtweb.dao;

import cn.nmtweb.bean.User;

public interface UserInfoDao {
    public User getUserInfo(String userName, String password);
    public boolean setUserInfo(User user);
    public boolean updateUserInfo(String attribute, String userName);
}
