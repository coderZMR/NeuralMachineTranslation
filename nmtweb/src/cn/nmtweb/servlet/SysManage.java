package cn.nmtweb.servlet;

import cn.nmtweb.bean.CorpusInfoItem;
import cn.nmtweb.bean.SysChangeItem;
import cn.nmtweb.service.DoCorpusInfoItemService;
import cn.nmtweb.service.DoCorpusService;
import cn.nmtweb.service.DoSysChangeService;
import cn.nmtweb.service.impl.DoCorpusInfoItemServiceImpl;
import cn.nmtweb.service.impl.DoCorpusServiceImpl;
import cn.nmtweb.service.impl.DoSysChangeServiceImpl;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class SysManage extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doPost(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        String target = req.getParameter("target");
        DoCorpusInfoItemService doCorpusInfoItemService = new DoCorpusInfoItemServiceImpl();
        DoSysChangeService sysChangeService = new DoSysChangeServiceImpl();
        String fileName;
        final SysChangeItem[] sysChangeItem = {null};
        Date day = new Date();
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currDate = df.format(day);
//        File storeDirectory = new File(getServletContext().getRealPath("/WEB-INF/corpus"));
        File storeDirectory = new File("L:\\nmttrain\\corpus");
        CorpusInfoItem corpusInfoItem = new CorpusInfoItem();
        switch (target) {
            case "SysMon":
                req.setAttribute("SysChangeItemList", sysChangeService.getSysChangeItemList());
                req.getRequestDispatcher("Admin_SysMon.jsp").forward(req, resp);
                break;
            case "CorpusMon":
                req.setAttribute("CorpusInfoItemList", doCorpusInfoItemService.getCorpusInfoItemList());
                req.getRequestDispatcher("Admin_CorpusMon.jsp").forward(req, resp);
                break;
            case "FileUpload":
                DiskFileItemFactory factory=new DiskFileItemFactory();
                //创建核心解析类ServlertFileUpload
                ServletFileUpload  sfu=new ServletFileUpload(factory);
                //解析请求对象
                List<FileItem> items=new ArrayList<FileItem>(0);
                try {
                    items=sfu.parseRequest(req);
                } catch (FileUploadException e) {
                    e.printStackTrace();
                }
                for(FileItem item:items){
                    if(item.isFormField()){
                        processFormField(item, corpusInfoItem);
                    }else{
                        processUploadField(item, corpusInfoItem);
                    }
                }
                corpusInfoItem.setIsUsed(0);
                corpusInfoItem.setCiDate(currDate);
                doCorpusInfoItemService.addCorpusInfoItem(corpusInfoItem);
                sysChangeItem[0] = new SysChangeItem();
                sysChangeItem[0].setOpt("语料库添加");
                sysChangeItem[0].setTarget(corpusInfoItem.getName());
                sysChangeItem[0].setcDate(currDate);
                sysChangeService.addSysChangeItem(sysChangeItem[0]);
                req.getRequestDispatcher("SysManage?target=CorpusMon").forward(req, resp);
                break;
            case "FileDownload":
                fileName = req.getParameter("filename") + ".txt";
                InputStream in = new FileInputStream(new File(storeDirectory, fileName));
                //用响应对象的输出流输出：下载的方式
                resp.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode(fileName,"UTF-8"));//不适用火狐
                resp.setContentType("application/octet-stream");
                OutputStream out = resp.getOutputStream();
                int len = -1;
                byte buf[] = new byte[1024];
                while((len=in.read(buf))!=-1){
                    out.write(buf, 0, len);
                }
                in.close();
                sysChangeItem[0] = new SysChangeItem();
                sysChangeItem[0].setOpt("语料库下载");
                sysChangeItem[0].setTarget(req.getParameter("filename"));
                sysChangeItem[0].setcDate(currDate);
                sysChangeService.addSysChangeItem(sysChangeItem[0]);
                break;
            case "FileDelete":
                String name = req.getParameter("filename");
                fileName = name + ".txt";
                File file = new File(storeDirectory, fileName);
                file.delete();
                doCorpusInfoItemService.deleteCorpusInfoItem(name);
                sysChangeItem[0] = new SysChangeItem();
                sysChangeItem[0].setOpt("语料库删除");
                sysChangeItem[0].setTarget(name);
                sysChangeItem[0].setcDate(currDate);
                sysChangeService.addSysChangeItem(sysChangeItem[0]);
                req.getRequestDispatcher("SysManage?target=CorpusMon").forward(req, resp);
                break;
            case "createHuTranCor":
                DoCorpusService doCorpusService = new DoCorpusServiceImpl();
                doCorpusService.createHuTranCor("L:\\nmttrain\\corpus");
                corpusInfoItem.setName("人工翻译语料库");
                corpusInfoItem.setComeFrom("NMT-Web 机器翻译平台");
                corpusInfoItem.setCiDate(currDate);
                corpusInfoItem.setIsUsed(0);
                doCorpusInfoItemService.addCorpusInfoItem(corpusInfoItem);
                sysChangeItem[0] = new SysChangeItem();
                sysChangeItem[0].setOpt("语料库添加");
                sysChangeItem[0].setTarget("人工翻译语料库");
                sysChangeItem[0].setcDate(currDate);
                sysChangeService.addSysChangeItem(sysChangeItem[0]);
                req.getRequestDispatcher("SysManage?target=CorpusMon").forward(req, resp);
                break;
            case "Train":
                req.setAttribute("CorpusInfoItemList", doCorpusInfoItemService.getCorpusInfoItemList());
                req.getRequestDispatcher("Admin_Train.jsp").forward(req, resp);
                break;
            case "TrainStart":
                String model = req.getParameter("model");
                String corpusName = req.getParameter("corpusName");
                String batch_size = req.getParameter("batch_size");
                String n_epoch = req.getParameter("n_epoch");
                String lr = req.getParameter("lr");
                String max_grad = req.getParameter("max_grad");
                String[] arg = new String[] {"python", "L:\\nmttrain\\Request_Train.py", model, corpusName, batch_size, n_epoch, lr, max_grad};
                final Process[] process = {null};
                if (req.getParameter("auto").equals("Yes")) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String train_time = req.getParameter("train_time");
                    Date ymdh = null;
                    try {
                        ymdh = sdf.parse(train_time);
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                    Timer timer = new Timer(true);
                    timer.schedule(
                            new TimerTask() {
                                @Override
                                public void run() {
                                    sysChangeItem[0] = new SysChangeItem();
                                    sysChangeItem[0].setOpt("模型训练");
                                    sysChangeItem[0].setTarget(model);
                                    sysChangeItem[0].setcDate(currDate);
                                    sysChangeService.addSysChangeItem(sysChangeItem[0]);
                                    doCorpusInfoItemService.updateCorpusInfoItem(corpusName);
                                    try {
                                        process[0] = Runtime.getRuntime().exec(arg);
                                        process[0].waitFor();
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                }
                            },
                            ymdh
                    );
                    req.setAttribute("SysChangeItemList", sysChangeService.getSysChangeItemList());
                    req.getRequestDispatcher("Admin_SysMon.jsp").forward(req, resp);
                }
                else {
                    sysChangeItem[0] = new SysChangeItem();
                    sysChangeItem[0].setOpt("模型训练");
                    sysChangeItem[0].setTarget(model);
                    sysChangeItem[0].setcDate(currDate);
                    sysChangeService.addSysChangeItem(sysChangeItem[0]);
                    doCorpusInfoItemService.updateCorpusInfoItem(corpusName);
                    String line;
                    String result = "";
                    try{
                        process[0] = Runtime.getRuntime().exec(arg);
                        process[0].waitFor();
                        InputStreamReader ir = new InputStreamReader(process[0].getInputStream());
                        LineNumberReader input = new LineNumberReader(ir);
                        while ((line = input.readLine()) != null) {
                            result += line + "<br/>";
                        }
                        input.close();
                        ir.close();
                    } catch (Exception e){
                        e.printStackTrace();
                    }
                    req.setAttribute("ConsoleResult", result);
                    req.setAttribute("CorpusInfoItemList", doCorpusInfoItemService.getCorpusInfoItemList());
                    req.getRequestDispatcher("Admin_Train.jsp").forward(req, resp);
                }
        }
    }

    // 对普通元素进行操作
    private void processFormField(FileItem item, CorpusInfoItem corpusInfoItem) {
        String fieldName=item.getFieldName();
        String fieldValue= null;
        try {
            fieldValue = new String(item.getString().getBytes("ISO8859_1"), "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
        switch (fieldName) {
            case "name":
                corpusInfoItem.setName(fieldValue);
                break;
            case "comeFrom":
                corpusInfoItem.setComeFrom(fieldValue);
                break;
        }
    }

    // 对文件元素进行操作
    private void processUploadField(FileItem item, CorpusInfoItem corpusInfoItem) {
        try {
            InputStream in=item.getInputStream();
            String fileName=corpusInfoItem.getName() + ".txt";
            String storeDirectoryRealPath = "L:\\nmttrain\\corpus";
            File storeDirectory=new File(storeDirectoryRealPath);

            if(!storeDirectory.exists()){
                storeDirectory.mkdirs();
            }

            fileName= FilenameUtils.getName(fileName);

            //构建输出流
            OutputStream out=new FileOutputStream(new File(storeDirectory,fileName));

            int len = -1;
            byte buf[] = new byte[1024];
            while((len=in.read(buf))!=-1){
                out.write(buf, 0, len);
            }
            in.close();
            out.close();


        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
