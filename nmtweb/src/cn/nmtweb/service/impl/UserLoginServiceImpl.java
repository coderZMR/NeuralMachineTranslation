package cn.nmtweb.service.impl;

import cn.nmtweb.dao.UserLoginDao;
import cn.nmtweb.dao.impl.UserLoginDaoImpl;
import cn.nmtweb.bean.User;
import cn.nmtweb.service.UserLoginService;

public class UserLoginServiceImpl implements UserLoginService {
    private UserLoginDao userLoginDao = new UserLoginDaoImpl();
    public boolean userLogin(User user) {
        return userLoginDao.userLogin(user);
    }
}
