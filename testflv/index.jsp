<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>FlowPlayer视频插件-计播放时长</title>
    <script src="js/jquery-1.4.2.js" type="text/javascript"></script>
	<script type="text/javascript" src="js/flowplayer-3.2.6.min.js"></script>
  </head>
  <body>
  	<div class="wbgVideo">
   		<!-- <a>标签为所要播放的视频 -->
		<a href="http://pseudo01.hddn.com/vod/demo.flowplayervod/flowplayer-700.flv"
		   style="display:block;width:520px;height:390px"  
		   id="player"> 
		</a> 
		<!-- 若视频开始为黑色  可以放一个图片作为背景  用js来控制图片与视频间的切换 
		<img class="backimg" src="images/back.jpg" style="cursor:pointer;" />
		-->
		<input type="hidden" id="videoStart" value="0" />
	</div>
	<script>
	var videoLen = 0;	//全局变量  记录视频播放总时长
	var flag = 1;		//标识当前视频的状态 0 播放状态 1暂停状态
	//var pauseflag = 0;	//是否是第一次进入暂停状态
	var videoPlayer; 	//保存当前播放器以便操作  
	videoPlayer = $f("player","js/flowplayer-3.2.7.swf",{
	    clip:{
			autoPlay: true,  		 	//是否自动播放，默认true
			autoBuffering: true, 	 	//是否自动缓冲视频，默认true
			onStart: function(clip){  	//开始播放时 执行方法
				var startDate = new Date();
				//记录开始播放时的系统时间
				$('#videoStart').val(startDate.getTime());
				flag = 0;				//标识为播放状态
			},
			onResume: function(clip){	//暂停后又播放 执行方法
				var startDate = new Date();
				//记录播放时的系统时间
	    		$('#videoStart').val(startDate.getTime());	
	    		flag = 0;				//标识为播放状态
	    	},
			onPause: function(clip){		//视频暂停时 执行方法
	    		videoLen = this.getTime();	//获得当前视频播放时长
	    		flag = 1;					//标识为暂停状态
	    	}							
		},
		onFinish: function() { 			//视频播放结束时 执行方法
			videoLen = this.getTime();	//获得视频总时长
		} 
	});
	
	//离开页面时执行此方法 计算播放时长
	function saveVideoLen(){
		alert(videoPlayer.currentClip.getDuration());
		//判断离开页面时视频的状态  播放或暂停
		if(flag==0){	//播放状态
	        var endDate = new Date();
	    	var endLen = (endDate.getTime()-$('#videoStart').val())/(1000);
	    	//播放时长为上一次暂停是取得的播放时长+最后一次resume到离开页面这段时间
	        videoLen = videoLen + endLen;	
	    }	//暂停状态时直接取全局变量videoLen当前视频播放时长即可
	    alert("播放时长为："+videoLen);
	}
	//点击播放时执行
	$('.backimg').click(function(){
		$('.backimg').hide();	//隐藏图片
		$('#player').show(); 	//显示视频 视频设置自动播放
	});
	</script>

	<input type="button" value="离开页面时得播放时长" onclick="saveVideoLen()" />

  </body>
</html>
