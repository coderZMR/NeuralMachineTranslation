package cn.nmtweb.service.impl;

import cn.nmtweb.bean.CorpusInfoItem;
import cn.nmtweb.dao.DoCorpusInfoItemDao;
import cn.nmtweb.dao.impl.DoCorpusInfoItemDaoImpl;
import cn.nmtweb.service.DoCorpusInfoItemService;

import java.util.List;

public class DoCorpusInfoItemServiceImpl implements DoCorpusInfoItemService {
    @Override
    public List<CorpusInfoItem> getCorpusInfoItemList() {
        DoCorpusInfoItemDao doCorpusInfoItemDao = new DoCorpusInfoItemDaoImpl();
        return doCorpusInfoItemDao.getCorpusInfoItemList();
    }

    @Override
    public boolean addCorpusInfoItem(CorpusInfoItem corpusInfoItem) {
        DoCorpusInfoItemDao doCorpusInfoItemDao = new DoCorpusInfoItemDaoImpl();
        return doCorpusInfoItemDao.addCorpusInfoItem(corpusInfoItem);
    }

    @Override
    public boolean deleteCorpusInfoItem(String name) {
        DoCorpusInfoItemDao doCorpusInfoItemDao = new DoCorpusInfoItemDaoImpl();
        return doCorpusInfoItemDao.deleteCorpusInfoItem(name);
    }

    @Override
    public boolean updateCorpusInfoItem(String name) {
        DoCorpusInfoItemDao doCorpusInfoItemDao = new DoCorpusInfoItemDaoImpl();
        return doCorpusInfoItemDao.updateCorpusInfoItem(name);
    }
}
