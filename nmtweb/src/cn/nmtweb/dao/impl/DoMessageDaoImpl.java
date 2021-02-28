package cn.nmtweb.dao.impl;

import cn.nmtweb.bean.Answer;
import cn.nmtweb.bean.Message;
import cn.nmtweb.dao.DoMessageDao;
import cn.nmtweb.util.JdbcUtil_dbcp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DoMessageDaoImpl implements DoMessageDao {
    @Override
    public boolean addMessage(Message message) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "INSERT INTO message(qId, aId, qUserName, aUserName, mDate, qString, aString, type) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, message.getqId());
            pstmt.setInt(2, message.getaId());
            pstmt.setString(3, message.getqUserName());
            pstmt.setString(4, message.getaUserName());
            pstmt.setString(5, message.getmDate());
            pstmt.setString(6, message.getqString());
            pstmt.setString(7, message.getaString());
            pstmt.setInt(8, message.getType());
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

    @Override
    public List<Message> getMessageList(String userName) {
        List<Message> AnsMesList = new ArrayList<>();
        List<Message> AccMesList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String AnsSql = "SELECT id, qId, aId, aUserName, mDate, qString, aString FROM message WHERE qUserName = ? and type = 0";
            pstmt = conn.prepareStatement(AnsSql);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setId(rs.getInt("id"));
                message.setqId(rs.getInt("qId"));
                message.setaId(rs.getInt("aId"));
                message.setqUserName(userName);
                message.setaUserName(rs.getString("aUserName"));
                message.setmDate(rs.getString("mDate"));
                message.setqString(rs.getString("qString"));
                message.setaString(rs.getString("aString"));
                message.setType(0);
                AnsMesList.add(message);
            }
            String AccSql = "SELECT id, qId, aId, qUserName, mDate, qString, aString FROM message WHERE aUserName = ? and type = 1";
            pstmt = conn.prepareStatement(AccSql);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Message message = new Message();
                message.setId(rs.getInt("id"));
                message.setqId(rs.getInt("qId"));
                message.setaId(rs.getInt("aId"));
                message.setqUserName(rs.getString("qUserName"));
                message.setaUserName(userName);
                message.setmDate(rs.getString("mDate"));
                message.setqString(rs.getString("qString"));
                message.setaString(rs.getString("aString"));
                message.setType(1);
                AccMesList.add(message);
            }
            AnsMesList.addAll(AccMesList);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return AnsMesList;  // AnsMesList已进行连接操作，包含AnsMesList与AccMesList所有元素
    }

    @Override
    public boolean deleteAll(String userName) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "DELETE FROM message WHERE aUserName = ? AND type = 1";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            pstmt.executeUpdate();
            sql = "DELETE FROM message WHERE qUserName = ? AND type = 0";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            pstmt.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

    @Override
    public boolean delete(int mId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "DELETE FROM message WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, mId);
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }
}
