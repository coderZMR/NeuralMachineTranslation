package cn.nmtweb.dao;

import cn.nmtweb.bean.SysChangeItem;

import java.util.List;

public interface DoSysChangeDao {
    List<SysChangeItem> getSysChangeItemList();
    boolean addSysChangeItem(SysChangeItem sysChangeItem);
}
