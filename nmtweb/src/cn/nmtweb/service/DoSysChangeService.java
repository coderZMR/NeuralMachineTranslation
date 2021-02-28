package cn.nmtweb.service;

import cn.nmtweb.bean.SysChangeItem;

import java.util.List;

public interface DoSysChangeService {
    List<SysChangeItem> getSysChangeItemList();
    boolean addSysChangeItem(SysChangeItem sysChangeItem);
}
