package cn.nmtweb.service;

import cn.nmtweb.bean.User;

public interface UserInfoService {
    public User getUserInfo(String userName, String password);
    public boolean setUserInfo(User user);
    public boolean updateUserInfo(String attribute, String userName);
}
