<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/7/27
  Time: 10:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="UTF-8">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <%@include file="/WEB-INF/common/css.jsp"%>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<jsp:include page="/WEB-INF/common/top.jsp"></jsp:include>

<div class="container-fluid">
    <div class="row">
        <jsp:include page="/WEB-INF/common/menu.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">


                    <form id="queryForm" class="form-inline" role="form" style="float:left;" action="${PATH}/admin/index" method="post">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" type="text" name="condition" value="${param.condition}"  placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button id="searchBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>


                    <button id="deleteBatchBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button id="saveBtn" type="button" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input id="theadCheckbox" type="checkbox"></th>
                                <th>名称</th>

                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>


                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                    </ul>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>






<!-- 添加模态框 -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加</h4>
            </div>
            <div class="modal-body">
                <form id="addForm" role="form" >
                    <div class="form-group">
                        <label >名称</label>
                        <input type="text" class="form-control" id="exampleInputPassword1" name="name" placeholder="请输入角色名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="saveModalBtn" type="button" class="btn btn-primary">保存</button>
            </div>
        </div>
    </div>
</div>
<!-- 修改模态框 -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel2">添加</h4>
            </div>
            <div class="modal-body">
                <form id="updateForm" role="form" >
                    <div class="form-group">
                        <label >名称</label>
                        <input type="hidden" name="id">
                        <input type="text" class="form-control" id="exampleInputPassword2" name="name" placeholder="请输入角色名称">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="updateModalBtn" type="button" class="btn btn-primary">修改</button>
            </div>
        </div>
    </div>
</div>


<%--给角色分配权限的模态框--%>
<div class="modal fade" id="permissionModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span>×</span>
                </button>
                <h4 class="modal-title">权限维护</h4>
            </div>
            <div class="modal-body">
                <ul id="assignPermissionToRoleTree" class="ztree"></ul>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button id="assignPermission" type="button" class="btn btn-primary">分配权限</button>
            </div>
        </div>
    </div>
</div>




<%@include file="/WEB-INF/common/js.jsp"%>
<script type="text/javascript">
    $(function () {//页面加载完成时，执行的事件处理
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
        showData(1);
    });


    var json={
        pageNum:1,
        pageSize:2,
        condition:""
    };


    var pageNum1=1;

        function showData(pageNum) {
            json.pageNum=pageNum;
            $.ajax({
                type:"POST",
                //data:{foo:["bar1","bar2"],name:"zhangsan",age:22},//
                data:json,
                url:"${PATH}/role/loadData",
                success:function (result) {

                    json.totalPages=result.pages;

                    console.log(result.list);
                    //显示列表数据
                    showTable(result.list);
                    //显示导航页码
                    showNavg(result);

                    pageNum1=result.pageNum;
                }
            });
        }

        //显示列表数据
        function showTable(list) {
            var content ='';//在js代码中，拼串使用单引号
            $.each(list,function (i,e) {
                content+='<tr>';
                content+='  <td>'+(i+1)+'</td>';
                content+='  <td><input roleId="'+e.id+'"  class="itemCheckboxClass" type="checkbox"></td>';
                content+='  <td>'+e.name+'</td>';
                content+='  <td>';
                content+='	  <button roleid="'+e.id+'" type="button" class="permissionModalPopBtn btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                content+='	  <button type="button" roleId="'+e.id+'" class="updateBtnClass btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
                content+='	  <button type="button" roleId="'+e.id+'" class="deleteBtnClass btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
                content+='  </td>';
                content+='</tr>';
            });
            $("tbody").html(content);
        }
        //显示导航页码
        function showNavg(pageInfo) {
            var  content='';
            if (pageInfo.isFirstPage){
                content+='<li class="disabled"><a href="#">上一页</a></li>';
            }else{
                content+='<li class="#"><a onclick="showData('+(pageInfo.pageNum-1)+')">上一页</a></li>';
            }


        $.each(pageInfo.navigatepageNums,function (i, num) {
            if (num==pageInfo.pageNum){
                content+='<li class="active"><a onclick="showData('+num+')">'+num+'</a></li>';
            }else {
                content+='<li><a onclick="showData('+num+')">'+num+'</a></li>';
            }

        });
        if (pageInfo.isLastPage){
            content+='<li class="disabled"><a href="#">下一页</a></li>';
        }else{
            content+='<li class="#"><a onclick="showData('+(pageInfo.pageNum+1)+')">下一页</a></li>';
        }
        $(".pagination").html(content);

    }





        //条件查询
        $("#searchBtn").click(function () {
           //获取查询条件
            var condition = $("#queryForm input[name='condition']").val();
            json.condition=condition;
            showData(1,condition);
        });


        //=====添加功能=========================================
        $("#saveBtn").click(function () {
            //弹出模态框
            $("#addModal").modal({
                show:true,
                backdrop:"static",
                keyboard:false
            });
        });
        //给添加模态框，添加，按钮增加单击事件
        $("#saveModalBtn").click(function () {
            //1.获取表单参数
            var name = $("#addModal input[name='name']").val();
            //2.发起Ajax请求，保存数据
            $.ajax({
                type:"POST",
                data:{
                    name:name
                },
                url:"${PATH}/role/doAdd",
                success:function (result) {
                    //3.判断是否保存成功，弹出消息
                    //4.关闭模态框
                    $("#addModal").modal("hide");
                    if (result=="ok"){
                        layer.msg("角色添加成功");
                        $("#addModal input[name='name']").val("");
                        //5.刷新表单列表
                        showData(json.totalPages + 1);
                    }else if(result=="403"){
                        layer.msg("您无权访问")
                    }
                    else {
                        layer.msg("角色添加失败");

                    }
                }
            });
        });

        //===============模态框版修改角色功能=====================================================
        //对也页面后来元素，增加事件处理时，不能用click(),需使用on
        /*$(".updateBtnClass").click(function () {
           layer.msg("aaaa")
        })*/
        $("tbody").on("click",".updateBtnClass",function () {
            //this.roleId;//不能通过dom对象获取自定义属性值
            //1.获取修改的数据id
            var roleId = $(this).attr("roleId");
            //2.发起ajax请求，查询数据
            $.get("${PATH}/role/getRoleById",{id:roleId},function (result) {//result==TRole==json{id:1,name,json}
                //3.回显数据
                $("#updateModal input[name='name']").val(result.name);
                $("#updateModal input[name='id']").val(result.id);
                //4.弹出模态框
                $("#updateModal").modal({
                    show:true,
                    backdrop:"static",//点背景页面，不关闭模态框
                    keyboard:false //点esc键，不关闭模态框
                })
            });

        });

        //角色模态框，修改功能
        $("#updateModalBtn").click(function () {
            //1.获取修改表单数据
            var name = $("#updateModal input[name='name']").val();
            var id = $("#updateModal input[name='id']").val();

            //2.提交ajax请求
            $.post("${PATH}/role/doUpdate",{id:id,name:name},function (result) {
                $("#updateModal").modal('hide');
                if (result=="ok"){
                    layer.msg("角色修改成功");
                    showData(json.pageNum);
                }else {
                    layer.msg("角色添加失败");

                }
            })

        })

        //==========角色模态框半删除功能===================================================
        $("tbody").on("click",".deleteBtnClass",function () {
            var roleId = $(this).attr("roleId");
            layer.confirm("您确定要删除吗?",{btn:['确定','取消']},function () {
                $.post("${PATH}/role/doDelete",{id:roleId},function (result) {
                    if (result=="ok"){
                        layer.msg("角色删除成功");
                        showData(json.pageNum);
                    }else {
                        layer.msg("角色删除失败");
                    }
                });
            },function () {

            });
        });

            //复选框联动
        $("#theadCheckbox").click(function () {
            var theadChecked = $(this).prop("checked");
            $(".itemCheckboxClass").prop("checked",theadChecked)
        });

        //一步删除多个角色
        $("#deleteBatchBtn").click(function () {
                var checkedboxList = $(".itemCheckboxClass:checked");
                if (checkedboxList==0){
                    layer.msg("请选择要删除的角色");
                    return false;
                }
                var idStr="";
                var idArray=new Array();
            $.each(checkedboxList,function (i, e) {
                var roleId = $(e).attr("roleId");
                idArray.push(roleId);

            });
            idStr=idArray.join(",");

            //同步请求方式，不跳回当前页码
            //layer.confirm("您确定要删除这些角色吗",{btn:['确定','取消']},function () {
            //    window.location.href="${PATH}/role/deleteBatch?ids="+idStr+"&pageNum="+pageNum1
            //},function () {})


            //异步请求方式，且跳回当前页码
            layer.confirm("您确定要删除吗?",{btn:['确定','取消']},function () {
                $.post("${PATH}/role/deleteBatch?",{ids:idStr,pageNum:pageNum1},function (result) {
                    if (result=="ok"){
                        layer.msg("角色删除成功");
                        showData(pageNum1);
                    }else {
                        layer.msg("角色删除失败");
                    }
                });
            },function () {});

        })



        //============给角色分配权限======================================================================
    var tempRid = 0;
    $("tbody").on("click",".permissionModalPopBtn",function(){
        //1.初始化权限树，带复选框
                initPermissioinToRoleTree();
        //2.显示模态框，展示权限树
                $("#permissionModal").modal({show:true,backdrop:"static"});
        tempRid = $(this).attr("roleid");
        showRolePermissions(tempRid);//回显
    });

    function initPermissioinToRoleTree(){
        var setting = {
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "pid"
                },
                key: {
                    url: "xUrl",
                    name:"title"
                }
            },
            check: {
                enable: true
            },
            view: {
                addDiyDom: addDiyDom
            }
        };

//1.加载数据
        $.get("${PATH}/permission/listAllPermissionTree",function(data){
//data.push({"id":0,"title":"系统权限","icon":"glyphicon glyphicon-asterisk"});//坑
            var tree = $.fn.zTree.init($("#assignPermissionToRoleTree"), setting, data);
            var treeObj = $.fn.zTree.getZTreeObj("assignPermissionToRoleTree");
            treeObj.expandAll(true);
        });
    }
    function addDiyDom(treeId,treeNode){
        $("#"+treeNode.tId+"_ico").removeClass();
        $("#"+treeNode.tId+"_span").before('<span class="'+treeNode.icon+'"></span>');
    }


    //分配权限功能
    $("#assignPermission").click(function(){
//1、获取到已经选中的所有权限的id
        var treeObj = $.fn.zTree.getZTreeObj("assignPermissionToRoleTree");
        var ids = new Array();
        $.each(treeObj.getCheckedNodes(true),function(){
            ids.push(this.id);
        });
        var idsStr = ids.join();

//2、组装给后台提交的数据
        alert(tempRid);
        var data = {rid:tempRid,perId:idsStr};
        console.log(data);
//3、发请求，完成权限分配功能
        $.post("${PATH}/permission/assign/assignPermissionToRole",data,function(){
            layer.msg("权限分配完成...");
            $("#permissionModal").modal('hide');

        })
    });



    //回显权限树
    function showRolePermissions(tempRid){
        var rid = tempRid;
        $.get("${PATH}/permission/role_permission?rid="+rid,function(data){
//1、遍历每一个权限，在ztree中选中对应的节点
            $.each(data,function(){
                console.log(this);
                var treeObj = $.fn.zTree.getZTreeObj("assignPermissionToRoleTree");
//根据指定的节点id搜索节点，null表示搜索整个树
                var node = treeObj.getNodeByParam("id", this.id, null);  //注意：不是getNodesByParam
//需要回显的节点，是否勾选复选框，父子节点勾选是否联动
                treeObj.checkNode(node,true,false);
            });
        });
    }
</script>
</body>
</html>

