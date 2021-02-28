package cn.nmtweb.dao.impl;

import cn.nmtweb.bean.CorpusInfoItem;
import cn.nmtweb.dao.DoCorpusInfoItemDao;
import cn.nmtweb.util.JdbcUtil_dbcp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DoCorpusInfoItemDaoImpl implements DoCorpusInfoItemDao {
    @Override
    public List<CorpusInfoItem> getCorpusInfoItemList() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<CorpusInfoItem> corpusInfoItemList = new ArrayList<>();
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "SELECT name, comeFrom, ciDate, isUsed FROM corpusinfo";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                CorpusInfoItem corpusInfoItem = new CorpusInfoItem();
                corpusInfoItem.setName(rs.getString("name"));
                corpusInfoItem.setComeFrom(rs.getString("comeFrom"));
                corpusInfoItem.setCiDate(rs.getString("ciDate"));
                corpusInfoItem.setIsUsed(rs.getInt("isUsed"));
                corpusInfoItemList.add(corpusInfoItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return corpusInfoItemList;
    }

    @Override
    public boolean addCorpusInfoItem(CorpusInfoItem corpusInfoItem) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "INSERT INTO corpusinfo(name, comeFrom, ciDate, isUsed) VALUES (?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, corpusInfoItem.getName());
            pstmt.setString(2, corpusInfoItem.getComeFrom());
            pstmt.setString(3, corpusInfoItem.getCiDate());
            pstmt.setInt(4, corpusInfoItem.getIsUsed());
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

    @Override
    public boolean deleteCorpusInfoItem(String name) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "DELETE FROM corpusinfo WHERE name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

    public boolean updateCorpusInfoItem(String name) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "UPDATE corpusinfo SET isUsed = 1 WHERE name = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, name);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

}
