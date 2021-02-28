package cn.nmtweb.service.impl;

import cn.nmtweb.bean.User;
import cn.nmtweb.dao.UserRegisterDao;
import cn.nmtweb.dao.impl.UserRegisterDaoImpl;
import cn.nmtweb.service.UserRegisterService;

public class UserRegisterServiceImpl implements UserRegisterService {
    private UserRegisterDao userRegisterDao = new UserRegisterDaoImpl();
    @Override
    public boolean userRegister(User user) {
        if (!userRegisterDao.userRegister(user)) return false;
        else return true;
    }
}
