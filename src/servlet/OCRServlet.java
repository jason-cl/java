package servlet;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.FileUtil;
import util.OCRUtil;
import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import com.jspsmart.upload.SmartUploadException;


public class OCRServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("gbk");
		SmartUpload upload = new SmartUpload();
		String path=request.getParameter("path");
//		JspFactory sf = JspFactory.getDefaultFactory();
//		upload.initialize(sf.getPageContext(this, request, response, null, false, JspWriter.DEFAULT_BUFFER, true));
		ServletConfig sc = this.getServletConfig();
		upload.initialize(sc, request, response);
		File file = null;
		long size = 5*1024*1024;
		upload.setAllowedFilesList("gif,jpg,bmp,png");
		upload.setMaxFileSize(size);
		upload.setCharset("GBK");
		try {
			upload.upload();
			file = upload.getFiles().getFile(0);
			String userPath = "upload\\";//+request.getRemoteAddr().replaceAll("\\.", "")+"\\";
			String svpath = userPath+file.getFileName();
			if(!file.isMissing()){
				String realPath = request.getRealPath("/");
				FileUtil.creatPath(realPath+userPath);
				file.saveAs(svpath,SmartUpload.SAVE_VIRTUAL);
				try {
					OCRUtil.runOCR(realPath, realPath+svpath, realPath+userPath+"ocr",true);
					request.setAttribute("txt", FileUtil.read(realPath+userPath+"ocr.txt"));//.trim());
					request.setAttribute("path",path);
					request.getRequestDispatcher("/index.jsp").forward(request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
				FileUtil.delete(realPath+userPath);
			}
		} catch (SmartUploadException e) {
			e.printStackTrace();
		}
	}

}
