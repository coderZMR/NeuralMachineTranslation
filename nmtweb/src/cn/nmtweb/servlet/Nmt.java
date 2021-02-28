package cn.nmtweb.servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.LineNumberReader;

public class Nmt extends HttpServlet {

    protected void doGet(HttpServletRequest request,
                      HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request,
                       HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        String type = request.getParameter("type");
        String userInput = request.getParameter("userInput");
        if (userInput == null || userInput.equals("")) {
            request.setAttribute("userInput", null);
            request.setAttribute("nmtOutput", null);
            if (type.equals("1"))
                request.getRequestDispatcher("nmt_En2Ch.jsp").forward(request, response);
            else
                request.getRequestDispatcher("nmt_Ch2En.jsp").forward(request, response);
        }
        String[] arg;
        if (type.equals("1"))
            arg = new String[] {"python", "L:\\nmtcore\\Request_En2Ch.py", "\"" + userInput + "\""};
        else
            arg = new String[] {"python", "L:\\nmtcore\\Request_Ch2En.py", "\"" + userInput + "\""};
        String result = null;
        try{
            System.out.println("@@@@@@@@@@@@@@@模型推测前@@@@@@@@@@@@@@" + userInput);
            Process process = Runtime.getRuntime().exec(arg);   /* 取得运行时环境并执行python脚本 */
            process.waitFor();                                  /* 等待脚本执行完毕 */
            /* 读取脚本运行后的输出结果 */
            InputStreamReader ir = new InputStreamReader(process.getInputStream());
            LineNumberReader input = new LineNumberReader(ir);
            System.out.println("-------------模型推测-------------");
            result = input.readLine();
            System.out.println("^^^^^^^^^^^^^模型推测后^^^^^^^^^^^^");
            input.close();
            ir.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        String nmtOutput = result;
        request.setAttribute("userInput", userInput);
        request.setAttribute("nmtOutput", nmtOutput);
        if (type.equals("1"))
            request.getRequestDispatcher("nmt_En2Ch.jsp").forward(request, response);
        else
            request.getRequestDispatcher("nmt_Ch2En.jsp").forward(request, response);
    }

}
