package cn.nmtweb.util;

import org.apache.commons.dbcp.BasicDataSourceFactory;

import javax.sql.DataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;


/**
 * 使用DBCP实现数据库连接
 *
 */
public class JdbcUtil_dbcp {
    private static DataSource bds = null;
    static{
        try {
            //读取配置文件
            Properties properties = new Properties();
            InputStream is = JdbcUtil_dbcp.class.getClassLoader().getResourceAsStream("dbcpconfig.properties");
            properties.load(is);
            bds = BasicDataSourceFactory.createDataSource(properties);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static Connection getConnection() throws SQLException {
        return bds.getConnection();
    }

    //释放资源
    public static void release(Connection conn,Statement stmt,ResultSet rs){
        if(rs!=null){
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(stmt!=null){
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if(conn!=null){
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
