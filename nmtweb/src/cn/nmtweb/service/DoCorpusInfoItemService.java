package cn.nmtweb.service;

import cn.nmtweb.bean.CorpusInfoItem;

import java.util.List;

public interface DoCorpusInfoItemService {
    List<CorpusInfoItem> getCorpusInfoItemList();
    boolean addCorpusInfoItem(CorpusInfoItem corpusInfoItem);
    boolean deleteCorpusInfoItem(String name);
    boolean updateCorpusInfoItem(String name);
}
