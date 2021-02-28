package cn.nmtweb.dao.impl;

import cn.nmtweb.bean.CorpusItem;
import cn.nmtweb.dao.DoCorpusDao;
import cn.nmtweb.util.JdbcUtil_dbcp;
import org.apache.commons.io.FilenameUtils;

import javax.servlet.ServletOutputStream;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DoCorpusDaoImpl implements DoCorpusDao {
    @Override
    public boolean addToCorpus(CorpusItem corpusItem) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "INSERT INTO corpus_en_cn(qString, aString) VALUES (?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, corpusItem.getqString());
            pstmt.setString(2, corpusItem.getaString());
            if (pstmt.executeUpdate() == 1) return true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, null);
        }
        return false;
    }

    @Override
    public boolean createHuTranCor(String storeDirectoryRealPath) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        try {
            String fileName = "人工翻译语料库" + ".txt";
            fileName= FilenameUtils.getName(fileName);
            File storeDirectory=new File(storeDirectoryRealPath);
            OutputStreamWriter pw = new OutputStreamWriter(new FileOutputStream(new File(storeDirectory, fileName)), "utf-8");
            conn = JdbcUtil_dbcp.getConnection();
            String sql = "SELECT qString, aString FROM corpus_en_cn";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            String content="";
            while (rs.next()) {
                content = rs.getString("qString") + "\r\n";
                pw.write(content);
                content = rs.getString("aString") + "\r\n";
                pw.write(content);
            }
            pw.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            JdbcUtil_dbcp.release(conn, pstmt, rs);
        }
        return false;
    }
}
