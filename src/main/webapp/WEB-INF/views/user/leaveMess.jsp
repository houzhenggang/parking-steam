<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>留言</title>
        <link rel="stylesheet" type="text/css" href="${APP_PATH}/static/css/showOrder.css">
        <link rel="stylesheet" href="${APP_PATH}/static/layui/css/layui.css"  />
        <script type="text/javascript" src="${APP_PATH}/static/layui/layui.js"></script>
        <script type="text/javascript" src="${APP_PATH}/static/js/jquery.min.js" ></script>
        <script type="text/javascript">
            $(function(){
            	/*
            	//获取当前时间
                function getNow()
                {
                    var time = new Date();
                    var dateArr = [];
                    dateArr[0] = time.getFullYear();
                    dateArr[1] = time.getMonth()+1;
                    dateArr[2] = time.getDate();
                    var str = dateArr[0];
                    for(let i=1;i<dateArr.length;i++)
                    {
                        if(dateArr[i]<10)
                        {
                            str +="-0"+dateArr[i];
                        }else{
                            str +="-"+dateArr[i];
                        }
                    }
                    return str;
                }
            	*/
                

                $(".save").click(function (){
                    var content = $(".content").val();
            
                    //新建一个标签元素tr保存信息
                    /*
                     var table = document.getElementsByClassName("my-table");
                    var tr = document.createElement("tr");
                    var t0 = document.createTextNode(content);//留言内容
                    var t1 = document.createTextNode(getNow());//留言时间
                    var t2 = document.createTextNode("");//空标签,填充空格部分
                    var t5 = document.createElement("a");
                    t5.innerHTML = "删除";

                    var td0 = document.createElement("td");
                    var td1 = document.createElement("td");
                    var td2 = document.createElement("td");
                    var td5 = document.createElement("td");
                    td0.appendChild(t0);
                    td1.appendChild(t1);
                    td2.appendChild(t2);
                    td5.appendChild(t5);

                    tr.appendChild("td0");
                    tr.appendChild("td1");
                    tr.appendChild("td2");
                    tr.appendChild("td2");
                    tr.appendChild("td2");
                    tr.appendChild("td5");
                    table.appendChild(tr);
                    */
                    
                    $.ajax({
                       url:"docomment",
                       type:"post",
                       data:{
                           comment:content
                       },
                        success:function (result) {
                            if(result.code == 1){
                                alert("留言成功!");
                                $(".content").val("");
                                window.location.href = "showOrder?status=4";
                            }else{
                                alert("留言失败!");
                                $(".content").val("");
                            }
                        },
                        error:function () {
                            alert("error!");
                        }
                    });
                });

                //实现删除
                $("a").click(function () {
                    var tr = $(this).parent().parent();//得到当前tr
                    //传用户名回去实现删除

                    $.ajax({
                       url:"deleteMess",
                       type:"post",
                       data:{},
                       success:function(result){
                           if(result == 1)
                           {
                               tr.empty();//删除当前tr行
                           }
                       }
                    });
                });
            });
        </script>
    </head>
    <body>
    <div class="mess_top">留言板</div>
    <div class="mess_bottom" style="padding-bottom: 50px;">
        <table class="layui-table my-table" lay-skin="line">
            <tr>
                <td>留言内容</td>
                <td>留言时间</td>
                <td>管理员回复</td>
                <td>回复人</td>
                <td>回复时间</td>
                <td>操作</td>
            </tr>

            <!--获取数据库留言信息并打印-->
            <c:forEach items="${commentlist}" var="comment">
            <tr style="text-align:center">
            	<td>${comment.comment}</td>
            	<td>${comment.getStringDate()}</td>
            	<td>${comment.replication}</td>
            	<td>${comment.adminId}</td>
            	<td>${comment.getStringReplyTime()}</td>
            	<td><a href="deletecomment?id=${comment.id}">删除</a></td>
            </tr>
            </c:forEach>
        </table>
    </div>
    <div class="mess_leave">我要留言</div>
    <div class="send_mess">
        <div>
            <p><textarea cols="150" name="content" rows="4" class="content"></textarea></p>
            <input class="save" style="float: right;" value="留言" type="button" />
        </div>
    </div>
    </body>
