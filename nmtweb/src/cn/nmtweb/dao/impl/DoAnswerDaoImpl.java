package cn.nmtweb.dao.impl;

import cn.nmtweb.bean.Answer;
import cn.nmtweb.dao.DoAnswerDao;
import cn.nmtweb.util.JdbcUtil_dbcp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DoAnswerDaoImpl implements DoAnswerDao {
    @Override
    public List<Answer> getAinfo(String userName) {
        List<Answer> aInfo = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "SELECT id, aString, qUserName, aDate, qId, accept FROM answer WHERE aUserName = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Answer answer = new Answer();
                answer.setId(rs.getInt("id"));
                answer.setaString(rs.getString("aString"));
                answer.setqUserName(rs.getString("qUserName"));
                answer.setaDate(rs.getString("aDate"));
                answer.setaUserName(userName);
                answer.setqId(rs.getInt("qId"));
                answer.setAccept(rs.getInt("accept"));
                aInfo.add(answer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return aInfo;
    }

    @Override
    public List<Answer> getAinfoByqId(int qId) {
        List<Answer> aInfo = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "SELECT id, aString, qUserName, aDate, aUserName, accept FROM answer WHERE qId = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, qId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Answer answer = new Answer();
                answer.setId(rs.getInt("id"));
                answer.setaString(rs.getString("aString"));
                answer.setqUserName(rs.getString("qUserName"));
                answer.setaDate(rs.getString("aDate"));
                answer.setaUserName(rs.getString("aUserName"));
                answer.setAccept(rs.getInt("accept"));
                aInfo.add(answer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return aInfo;
    }

    @Override
    public boolean addAnswer(Answer answer) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "INSERT INTO answer(aString, qUserName, aDate, aUserName, qId, accept) VALUES (?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, answer.getaString());
            pstmt.setString(2, answer.getqUserName());
            pstmt.setString(3, answer.getaDate());
            pstmt.setString(4, answer.getaUserName());
            pstmt.setInt(5, answer.getqId());
            pstmt.setInt(6, answer.getAccept());
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

    @Override
    public int getMaxId() {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int result = 0;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "SELECT MAX(id) FROM answer";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            rs.next();
            result = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return result;
    }

    @Override
    public boolean updateAccept(int aId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "UPDATE answer SET accept = 1 WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, aId);
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }
}
