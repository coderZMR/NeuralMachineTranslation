package cn.nmtweb.dao.impl;

import cn.nmtweb.bean.Question;
import cn.nmtweb.dao.DoQuestionDao;
import cn.nmtweb.util.JdbcUtil_dbcp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

public class DoQuestionDaoImpl implements DoQuestionDao {
    @Override
    public List<Question> getQinfo(String userName) {
        List<Question> qInfo = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = null;
            if (!"All".equals(userName)) {
                sql = "SELECT id, qString, qDate, aNum FROM question WHERE userName=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, userName);
            }
            else {
                sql = "SELECT id, qString, userName, qDate, aNum, end FROM question";
                pstmt = conn.prepareStatement(sql);
            }
            rs = pstmt.executeQuery();
            while (rs.next()) {
                Question question = new Question();
                question.setId(rs.getInt("id"));
                question.setqString(rs.getString("qString"));
                if (userName.equals("All")) question.setUserName(rs.getString("userName"));
                else question.setUserName(userName);
                question.setqDate(rs.getString("qDate"));
                question.setaNum(rs.getInt("aNum"));
                if (userName.equals("All")) question.setEnd(rs.getInt("end"));
                qInfo.add(question);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return qInfo;
    }

    @Override
    public boolean addQinfo(Question question) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "INSERT INTO question(qString, userName, qDate, aNum, end) VALUES (?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, question.getqString());
            pstmt.setString(2, question.getUserName());
            pstmt.setString(3, question.getqDate());
            pstmt.setInt(4, question.getaNum());
            pstmt.setInt(5,question.getEnd());
            return pstmt.execute();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

    @Override
    public Question getQuestionById(int qId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Question question = new Question();
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = null;
            sql = "SELECT qString, userName, qDate, aNum, end FROM question WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, qId);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                question.setqString(rs.getString("qString"));
                question.setUserName(rs.getString("userName"));
                question.setqDate(rs.getString("qDate"));
                question.setaNum(rs.getInt("aNum"));
                question.setEnd(rs.getInt("end"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return question;
    }

    @Override
    public boolean UpdateQuestionById(int qId, int aNum) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = null;
            sql = "UPDATE question SET aNum=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, aNum + 1);
            pstmt.setInt(2, qId);
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

    @Override
    public boolean UpdateEnd(int qId) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "UPDATE question SET end = 1 WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, qId);
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }
}
