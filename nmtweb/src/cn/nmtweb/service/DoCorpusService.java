package cn.nmtweb.service;

import cn.nmtweb.bean.CorpusItem;

public interface DoCorpusService {
    public boolean addToCorpus(CorpusItem corpusItem);
    public boolean createHuTranCor(String storeDirectoryRealPath);
}
