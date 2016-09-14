var timing_schedule=function(){
  this.data;
  _this=this;
};
//请求方法
timing_schedule.prototype.ajaxData=function(request,requestUrl,requestList){
  $.ajax({
    url:requestUrl,// 跳转到 action
    type:request,
    data:requestList,
    cache:false,
    dataType:'json',
    success:function(data){
      _this.data=data;
    },
    error : function() {
      alert("异常！");
    }
  });
  return this;
}

