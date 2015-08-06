<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>兰途OCR-beta</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<style>
	   body{padding:0;margin:0;font-family:"微软雅黑";background:#fafafa;}
       .wrapper{max-width:1200px;width:1200px;margin:0 auto;padding:30px 0;}
       .fileup .filename{color:#96bf82;font-size:18px;padding-right:10px;}
       .fileup .pathname{padding:8px 10px;border:1px solid #cbe6bd;min-width:300px;border-radius:6px;color:#9cc289;font-size:16px;margin-right:15px;}
        .fileup .btn{padding:8px 15px;color:#fff;font-weight:bold;font-size:16px;border-radius:5px;cursor:pointer;}
       .fileup .filewrap{position:relative;border:1px solid #85b96c;background:#acd598;}
       .fileup .file{position:absolute;top:0px;left:0px;bottom:0px;right:0px;border:1px solid red;width:90px;opacity:0;}
       .fileup .startOCR{background:#ff7a7a;border:1px solid #dd4f4f;margin-left:15px;}
       .fileup .bz{color:#cecece;font-size:12px;}
       .showPanel{overflow:hidden;zoom:1;width:100%;margin-top:20px;}
       .showPanel .divs{width:48%;border:1px solid #cbe6bd;border-radius:5px;height:500px;background:#fff;overflow-y:hidden;overflow-x:hidden;}
       .showPanel .img{float:left;}
       .showPanel .txt{float:right;position:relative;}
       .showPanel .txt textarea{width:100%;height:100%;resize:none;border:none;font-size:12px;}
       .showPanel .txt .load{position:absolute;top:50%;margin-top:-40px;display:none;opacity:0;left:50%;margin-left:-10%;width:66px;height:66px;}
       .showPanel .txt .load img{border:none;}
       .showPanel .txt .load.show{opacity:1;display:block;}
	</style>

  </head>
  <body>
    <div class="wrapper">
	   <div class="fileup">
	         <form enctype="multipart/form-data" method="post" action="" id="myform">
	           <input type="hidden" name="path" id="hidUrl" />
	           <label class="filename">提交文件:</label><input type="text" class="pathname" />
	           <a class="filewrap btn">上传图片<input type="file" id="fileimg"  name="upload" class="file" /></a>
	           <input type="button" onclick="check()"  value="开始识别" class="startOCR btn"  />
	         </form>
	         <p class="bz">图片只能为扩展名.gif .jpg .bmp .png文件</p>
	   </div>
	   <div class="showPanel">
	      <div class="img divs" id="img"><img id="imgShow" src="<%=request.getAttribute("path")==null?"":request.getAttribute("path") %>" width="100%" height="100%" /></div>
	      <div class="txt divs">
	         <textarea id="text">
			<%
			    Object txt = request.getAttribute("txt"); 
				if(txt!=null&&txt.toString().length()==0){
					out.print("未识别出任何文字！");
				}else if(txt!=null){
					out.print(txt.toString());
				}
			%></textarea>
	         <div class="load"><img src="load.gif" /></div>
	      </div>
	   </div>
	</div>
	
<script src="jquery.min.js"></script>
<script src="uploadPreview.min.js"></script>
<script>
new uploadPreview({ UpBtn: "fileimg", DivShow: "img", ImgShow: "imgShow" });
function check(){
	var path = document.getElementById("fileimg").value;
	if(path.length==0){
		alert("请选择要导入的图片！");
		return false;
	}
	if(!(path.match(/.jpg$/i)||path.match(/.bmp$/i)||path.match(/.gif$/i)||path.match(/.png$/i))){
		alert("只支持JPG,BMP,GIF,PNG格式！");
		return false;
	}else {
		$(".load").addClass("show");
		$("#myform").attr("action","OCRServlet?path="+$("#hidUrl").val());
		$("#myform").submit();
	}
	return true;
}
</script>
 </body>
</html>
