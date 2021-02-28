package cn.nmtweb.service.impl;

import cn.nmtweb.bean.User;
import cn.nmtweb.dao.UserInfoDao;
import cn.nmtweb.dao.impl.UserInfoDaoImpl;
import cn.nmtweb.service.UserInfoService;

public class UserInfoServiceImpl implements UserInfoService {
    @Override
    public User getUserInfo(String userName, String password) {
        UserInfoDao userInfoDao = new UserInfoDaoImpl();
        return userInfoDao.getUserInfo(userName, password);
    }

    @Override
    public boolean setUserInfo(User user) {
        UserInfoDao userInfoDao = new UserInfoDaoImpl();
        if (userInfoDao.setUserInfo(user)) return true;
        else return false;
    }

    @Override
    public boolean updateUserInfo(String attribute, String userName) {
        UserInfoDao userInfoDao = new UserInfoDaoImpl();
        if (userInfoDao.updateUserInfo(attribute, userName)) return true;
        else return false;
    }
}
