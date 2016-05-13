//设置URL参数的方法  
      function setParmsValue(parms, parmsValue) {  
          var urlstrings = document.URL;  
          var args = GetUrlParms();  
          var values = args[parms];  

          //如果参数不存在，则添加参数         
          if (values == undefined) {  
              var query = location.search.substring(1); //获取查询串   
              //如果Url中已经有参数，则附加参数  
              if (query) {  
                  urlstrings += ("&" + parms + "=" + parmsValue);  
                  console.log("111111...:",urlstrings);
              }  
              else {  
                  urlstrings += ("?" + parms + "=" + parmsValue);  //向Url中添加第一个参数  
                  console.log("22222...:",urlstrings);
              }  
              console.log("urlstrings...:",urlstrings);
              window.location = urlstrings;  
          }  
          else {  
              window.location = updateParms(parms, parmsValue);  //修改参数  
          }  
      }  
  
      //修改URL参数，parms：参数名，parmsValue：参数值，return：修改后的URL  
      function updateParms(parms, parmsValue,url) {  
          var newUrlParms = "";
          var url =   arguments[2] || location.href;
          var newUrlBase = url.substring(0, url.indexOf("?") + 1); //截取查询字符串前面的url 
          console.log('newUr截取查询字符串前面的urllBase---->:',newUrlBase);
          var query = url.split('?')[1]; //获取查询串
          if(!query){
            return url + '?' + parms + '=' + parmsValue;
          }  
          var pairs = query.split("&"); //在逗号处断开 
          var flag = 0; //标识是否找到   
          for (var i = 0; i < pairs.length; i++) {  
              var pos = pairs[i].indexOf('='); //查找name=value     
              if (pos == -1) continue; //如果没有找到就跳过     
              var argname = pairs[i].substring(0, pos); //提取name     
              var value = pairs[i].substring(pos + 1); //提取value   
              //如果找到了要修改的参数  
              if (findText(argname, parms)) {
                    flag = 1;
                  newUrlParms = newUrlParms + (argname + "=" + parmsValue + "&");  
              }
              else {  
                  newUrlParms += (argname + "=" + value + "&");  
              }  
          }
//          如果最后还是没找到参数则添加参数值
          if(flag == 0){
            return url + '&' + parms + '=' + parmsValue;
          }else{
            return newUrlBase + newUrlParms.substring(0, newUrlParms.length - 1);
          }
            
      }  
  
      //辅助方法  
      function findText(urlString, keyWord) {  
          return urlString.toLowerCase().indexOf(keyWord.toLowerCase()) != -1 ? true : false;  
      }  
  
      //得到查询字符串参数集合  
      function GetUrlParms() {  
          var args = new Object();  
          var query = location.search.substring(1); //获取查询串     
          var pairs = query.split("&"); //在逗号处断开     
          for (var i = 0; i < pairs.length; i++) {  
              var pos = pairs[i].indexOf('='); //查找name=value     
              if (pos == -1) continue; //如果没有找到就跳过
              var argname = pairs[i].substring(0, pos); //提取name     
              var value = pairs[i].substring(pos + 1); //提取value     
              args[argname] = decodeURIComponent(value); //存为属性     
          }  
          return args;  
      }