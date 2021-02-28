package cn.nmtweb.dao.impl;

import cn.nmtweb.bean.User;
import cn.nmtweb.dao.UserInfoDao;
import cn.nmtweb.util.JdbcUtil_dbcp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserInfoDaoImpl implements UserInfoDao {
    @Override
    public User getUserInfo(String userName, String password) {
        User user = new User();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "SELECT acceptNum, answerNum, comeFrom, email, lastLoginTime, questionNum, sex, signature, userType FROM userinfo WHERE userName = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            rs = pstmt.executeQuery();
            while (rs.next()) {
                user.setUserName(userName);
                user.setPassword(password);
                user.setAcceptNum(rs.getString("acceptNum"));
                user.setAnswerNum(rs.getString("answerNum"));
                user.setComeFrom(rs.getString("comeFrom"));
                user.setEmail(rs.getString("email"));
                user.setLastLoginTime(rs.getString("lastLoginTime"));
                user.setQuestionNum(rs.getString("questionNum"));
                user.setSex(rs.getString("sex"));
                user.setSignature(rs.getString("signature"));
                user.setUserType(rs.getString("userType"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return user;
    }

    @Override
    public boolean setUserInfo(User user) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "UPDATE userinfo SET sex=?, comeFrom=?, signature=?, email=? WHERE userName=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getSex());
            pstmt.setString(2, user.getComeFrom());
            pstmt.setString(3, user.getSignature());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getUserName());
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        if (result == 1) return true;
        else return false;
    }

    @Override
    public boolean updateUserInfo(String attribute, String userName) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        int result = 0;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = null;
            switch (attribute) {
                case "questionNum":
                    sql = "UPDATE userinfo SET questionNum = questionNum + 1 WHERE userName = ?";
                    break;
                case "answerNum":
                    sql = "UPDATE userinfo SET answerNum = answerNum + 1 WHERE userName = ?";
                    break;
                case "acceptNum":
                    sql = "UPDATE userinfo SET acceptNum = acceptNum + 1 WHERE userName = ?";
                    break;
            }
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userName);
            result = pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        if (result == 1) return true;
        else return false;
    }
}
