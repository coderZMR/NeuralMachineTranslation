package cn.nmtweb.dao.impl;

import cn.nmtweb.bean.User;
import cn.nmtweb.dao.UserRegisterDao;
import cn.nmtweb.util.JdbcUtil_dbcp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class UserRegisterDaoImpl implements UserRegisterDao {
    @Override
    public boolean userRegister(User user) {
        Date day = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String lastLoginTime = df.format(day);
        boolean ifRegister = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "INSERT INTO userlogin VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, user.getPassword());
            pstmt.executeUpdate();
            sql = "INSERT INTO userinfo VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserName());
            pstmt.setString(2, lastLoginTime);
            pstmt.setInt(3, 0);
            pstmt.setInt(4, 0);
            pstmt.setInt(5, 0);
            pstmt.setString(6, "普通用户");
            pstmt.setString(7, "男");
            pstmt.setString(8, "未填写");
            pstmt.setString(9, "未填写");
            pstmt.setString(10, "未填写");
            pstmt.executeUpdate();
            ifRegister = true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return ifRegister;
    }
}
