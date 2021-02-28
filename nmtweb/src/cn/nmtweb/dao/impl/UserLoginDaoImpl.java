package cn.nmtweb.dao.impl;

import cn.nmtweb.dao.UserLoginDao;
import cn.nmtweb.bean.User;
import cn.nmtweb.util.JdbcUtil_dbcp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.SimpleTimeZone;

public class UserLoginDaoImpl implements UserLoginDao {
    public boolean userLogin(User user) {
        boolean ifLogin = false;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Date day = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String lastLoginTime = df.format(day);
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "SELECT password FROM userLogin WHERE userName = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, user.getUserName());
            rs = pstmt.executeQuery();
            while (rs.next()) {
                if (rs.getString("password").equals(user.getPassword())) ifLogin = true;
                sql = "UPDATE userInfo SET lastLoginTime = ? WHERE userName = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, lastLoginTime);
                pstmt.setString(2, user.getUserName());
                pstmt.execute();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return ifLogin;
    }
}
