package cn.nmtweb.dao;

import cn.nmtweb.bean.CorpusInfoItem;

import java.util.List;

public interface DoCorpusInfoItemDao {
    List<CorpusInfoItem> getCorpusInfoItemList();
    boolean addCorpusInfoItem(CorpusInfoItem corpusInfoItem);
    boolean deleteCorpusInfoItem(String name);
    boolean updateCorpusInfoItem(String name);
}
