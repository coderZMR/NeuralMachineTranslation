package cn.nmtweb.service.impl;

import cn.nmtweb.bean.SysChangeItem;
import cn.nmtweb.dao.DoSysChangeDao;
import cn.nmtweb.dao.impl.DoSysChangeDaoImpl;
import cn.nmtweb.service.DoSysChangeService;

import java.util.List;

public class DoSysChangeServiceImpl implements DoSysChangeService {
    @Override
    public List<SysChangeItem> getSysChangeItemList() {
        DoSysChangeDao doSysChangeDao = new DoSysChangeDaoImpl();
        return doSysChangeDao.getSysChangeItemList();
    }

    @Override
    public boolean addSysChangeItem(SysChangeItem sysChangeItem) {
        DoSysChangeDao doSysChangeDao = new DoSysChangeDaoImpl();
        return doSysChangeDao.addSysChangeItem(sysChangeItem);
    }
}
