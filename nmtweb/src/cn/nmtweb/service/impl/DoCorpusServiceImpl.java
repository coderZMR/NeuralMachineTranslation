package cn.nmtweb.service.impl;

import cn.nmtweb.bean.CorpusItem;
import cn.nmtweb.dao.DoCorpusDao;
import cn.nmtweb.dao.impl.DoCorpusDaoImpl;
import cn.nmtweb.service.DoCorpusService;

public class DoCorpusServiceImpl implements DoCorpusService {
    @Override
    public boolean addToCorpus(CorpusItem corpusItem) {
        DoCorpusDao doCorpusDao = new DoCorpusDaoImpl();
        return doCorpusDao.addToCorpus(corpusItem);
    }

    @Override
    public boolean createHuTranCor(String storeDirectoryRealPath) {
        DoCorpusDao doCorpusDao = new DoCorpusDaoImpl();
        return doCorpusDao.createHuTranCor(storeDirectoryRealPath);
    }
}
