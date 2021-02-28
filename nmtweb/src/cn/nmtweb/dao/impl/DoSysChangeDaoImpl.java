package cn.nmtweb.dao.impl;

import cn.nmtweb.bean.Answer;
import cn.nmtweb.bean.SysChangeItem;
import cn.nmtweb.dao.DoSysChangeDao;
import cn.nmtweb.util.JdbcUtil_dbcp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DoSysChangeDaoImpl implements DoSysChangeDao {
    @Override
    public List<SysChangeItem> getSysChangeItemList() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<SysChangeItem> sysChangeItems = new ArrayList<>();
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "SELECT id, opt, target, cDate FROM syschange";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                SysChangeItem sysChangeItem = new SysChangeItem();
                sysChangeItem.setId(rs.getInt("id"));
                sysChangeItem.setOpt(rs.getString("opt"));
                sysChangeItem.setTarget(rs.getString("target"));
                sysChangeItem.setcDate(rs.getString("cDate"));
                sysChangeItems.add(sysChangeItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return sysChangeItems;
    }

    @Override
    public boolean addSysChangeItem(SysChangeItem sysChangeItem) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "INSERT INTO syschange(opt, target, cDate) VALUES (?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, sysChangeItem.getOpt());
            pstmt.setString(2, sysChangeItem.getTarget());
            pstmt.setString(3, sysChangeItem.getcDate());
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }
}
