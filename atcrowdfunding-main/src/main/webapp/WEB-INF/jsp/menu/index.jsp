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

    <li class="aa bb dd ">cc</li>

    <div class="row">
        <jsp:include page="/WEB-INF/common/menu.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
                </div>

        </div>
    </div>
</div>
<!-- 菜单添加模态框Modal -->
<div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="AddModal">
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
<h4 class="modal-title" id="myModalLabel">添加菜单</h4>
</div>
<form id="addMenuForm">
<div class="modal-body">
<div class="form-group">
<label for="addFormPid">菜单名称</label>
<input type="hidden" id="addFormPid" name="pid" value="">
<input type="text" class="form-control" id="addFormName" name="name"  placeholder="请输入菜单名称">
</div>
</div>
<div class="modal-body">
<div class="form-group">
<label for="addFormIcon">菜单图标</label>
<input type="text" class="form-control" id="addFormIcon" name="icon"  placeholder="请输入菜单图标">
</div>
</div>
<div class="modal-body">
<div class="form-group">
<label for="addFormUrl">菜单URL</label>
<input type="text" class="form-control" id="addFormUrl" name="url"  placeholder="请输入菜单URL">
</div>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
<button type="button" class="btn btn-primary" onclick="saveMenu()">保存</button>
</div>
</form>
</div>
</div>
</div>
</div>





<!--修改按钮模态框 Modal -->
<div class="modal fade" id="UpdateModal" tabindex="-1" role="dialog" aria-labelledby="AddModal">
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
<h4 class="modal-title" id="myModalLabel1">修改菜单</h4>
</div>
<form id="addMenuForm1">


<div class="modal-body">
<div class="form-group">
<label for="addFormId">菜单名称</label>
<input type="hidden" id="addFormId" name="id" >
<input type="text" class="form-control" id="addFormName1" name="name"  placeholder="请输入菜单名称">
</div>
</div>
<div class="modal-body">
<div class="form-group">
<label for="addFormIcon">菜单图标</label>
<input type="text" class="form-control" id="addFormIcon1" name="icon"  placeholder="请输入菜单图标">
</div>
</div>
<div class="modal-body">
<div class="form-group">
<label for="addFormUrl">菜单URL</label>
<input type="text" class="form-control" id="addFormUrl1" name="url"  placeholder="请输入菜单URL">
</div>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
<button type="button" class="btn btn-primary" onclick="updateMenu()">修改</button>
</div>
</form>
</div>
</div>
</div>





<!-- 分配权限Modal -->
<div class="modal fade" id="permissionModal" tabindex="-1" role="dialog" aria-labelledby="Modal">
<div class="modal-dialog" role="document">
<div class="modal-content">
<div class="modal-header">
<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
<h4 class="modal-title" id="myModalLabel2">给菜单分配权限</h4>
</div>
<div class="modal-body">
 <ul id="assignPermissionTree" class="ztree"></ul>
</div>
<div class="modal-footer">
<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>

<button id="assignPermission11" type="button" onclick="" class="btn btn-primary">分配权限</button>
</div>
</div>
</div>
</div>





<%@include file="/WEB-INF/common/js.jsp"%>
<script type="text/javascript">
    $(function () {
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
        showTree();

        /*alert($(".bb").html());*/

    });





    function showTree() {
        var setting = {
            data: {
                simpleData: {
                    enable: true,
                    pIdKey:'pid'
                },
            },
            view:{
            addDiyDom:customeIcon,//添加按钮样式

            addHoverDom:customeAddBtn,//显示按钮
            removeHoverDom: removeHoverDom //移除按钮
            }
        };

        var zNodes ={ };
        $.get("${PATH}/menu/loadTree",{},function(result) {
            zNodes=result;
            //增加根节点
            zNodes.push({"id":0,"name":"系统权限菜单","icon":"glyphicon glyphicon glyphicon-tasks","children":[]});
            //初始化树
             var treeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            //获取树并展开所有节点
            //var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            treeObj.expandAll(true);

        });


    }

    //给树节点增加自定义  字体图标
    //treeId  表示生成树的位置，即容器id
    //treeNode  节点对象，一个节点对象，相当于一个TMenu对象
    function customeIcon(treeId,treeNode){
        //tId  由treeId+“_"+序号
        //tId + "_ico" 获取显示字体图标的元素
        $("#"+treeNode.tId+"_ico").removeClass();
        //tId + "_span"获取显示节点名称的元素   然后将获取的的节点的icon格式，追加到前面
        $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>")

    }
    var id1=1;
    //给弹出的树增加选项按钮
    function customeAddBtn(treeId, treeNode){
        var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
        aObj.attr("href", "javascript:;");//禁用连接   仅适用于部分游览器
        aObj.attr("onclick", "return false;");//禁用单击事件



        if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0){
            return;
        }

        id1=treeNode.id;
        // alert(id1)
        var s = '<span id="btnGroup'+treeNode.tId+'">';
        if ( treeNode.level == 0 ) {
            s += '<a   class="plusBtn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn(id1)" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="assignBtn('+treeNode.id+')" >  <i class="fa fa-fw fa-anchor rbg "></i></a>';
        } else if ( treeNode.level == 1 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn(id1)" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
            if (treeNode.children.length == 0) {
                s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn(id1)" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
            }
            s += '<a  class="plusBtn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn(id1)" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="assignBtn('+treeNode.id+')" >  <i class="fa fa-fw fa-anchor rbg "></i></a>';
        } else if ( treeNode.level == 2 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn(id1)" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn(id1)" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="#" onclick="assignBtn('+treeNode.id+')" >  <i class="fa fa-fw fa-anchor rbg "></i></a>';
        }
        s += '</span>';
        aObj.after(s);


    }

    //给弹出的树移除选项按钮
    function removeHoverDom(treeId, treeNode){
        $("#btnG" +
    "roup"+treeNode.tId).remove();
    }





        //菜单添加事件
        function addBtn(id){
        $("#addFormPid").val(id);
        $("#AddModal").modal({show:true,backdrop:'static',keyboard:false})
        }


        function saveMenu(){
        var pid = $("#addFormPid").val();
        var name = $("#addFormName").val();
        var icon = $("#addFormIcon").val();
        var url = $("#addFormUrl").val();
        $.post("${PATH}/menu/add",{pid:pid,name:name,icon:icon,url:url},function(result){
        if(result=="ok"){
        $("#AddModal").modal("hide");
        showTree();
        }
        });
        /* $("#addFormPid").val("");
        $("#addFormName").val("");
        $("#addFormIcon").val("");
        $("#addFormUrl").val(""); */
        $("#addMenuForm")[0].reset();
        }

        //菜单的修改事件
        function updateBtn(id){
            $.get("${PATH}/menu/get",{id:id},function(result){
            $("#UpdateModal input[name='id']").val(result.id);
            $("#UpdateModal input[name='name']").val(result.name);
            $("#UpdateModal input[name='icon']").val(result.icon);
            $("#UpdateModal input[name='url']").val(result.url);
            $("#UpdateModal").modal({show:true,backdrop:'static',keyboard:false})
        });
        }
         
        function updateMenu(){
            var id = $("#UpdateModal input[name='id']").val();
            var name = $("#UpdateModal input[name='name']").val();
            var icon = $("#UpdateModal input[name='icon']").val();
            var url = $("#UpdateModal input[name='url']").val();

            $.post("${PATH}/menu/edit",{id:id,name:name,icon:icon,url:url},function(result){
                if(result=="ok"){
                $("#UpdateModal").modal("hide");
                showTree()


                }
            });
        }

        //菜单删除事件
        function deleteBtn(id){
            layer.confirm("确定要删除这个菜单吗?",{btn:["确定","取消"]},function(index){
            $.post("${PATH}/menu/delete",{id:id,_method:"delete"},function(result){
            if(result=="ok"){
            showTree();
            }
            });
            layer.close(index);
            },function(index){
            layer.close(index);
            });

        }

        //===================菜单的分配权限========================================================================
    var tempMenuid = '';
    function assignBtn(menuid){
        tempMenuid = menuid;
        //1.初始化权限树，带复选框
        initPermissioinToMenuTree();
        //2.显示模态框，展示权限树
        $("#permissionModal").modal({show:true,backdrop:"static"});
        //3.回显权限树（之前分配过的权限应该被勾选）
        showMenuPermissions(menuid);
    }
    function initPermissioinToMenuTree(){
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
            //data.push({"id":0,"title":"系统权限","icon":"glyphicon glyphicon-asterisk"});
            var tree = $.fn.zTree.init($("#assignPermissionTree"), setting, data);
            var treeObj = $.fn.zTree.getZTreeObj("assignPermissionTree");
            treeObj.expandAll(true);
        });
    }
    function addDiyDom(treeId,treeNode){
        $("#"+treeNode.tId+"_ico").removeClass();
        $("#"+treeNode.tId+"_span").before('<span class="'+treeNode.icon+'"></span>');
    }




    //分配权限功能
    $("#assignPermission11").click(function(){
        //1、获取到已经选中的所有权限的id
        var treeObj = $.fn.zTree.getZTreeObj("assignPermissionTree");
        var ids = new Array();
        $.each(treeObj.getCheckedNodes(true),function(){
            ids.push(this.id);
        });
        var idsStr = ids.join();
         
        //2、组装给后台提交的数据
        var data = {mid:tempMenuid,perIds:idsStr};
        console.log(data);
        //3、发请求，完成权限分配功能
        $.post("${PATH}/permission/assignPermissionToMenu",data,function(){
            layer.msg("权限分配完成...")
            $("#permissionModal").modal('hide');
        })
    });



    //回显权限树
    function showMenuPermissions(menuid){
        $.get("${PATH}/menu/menu_permission?menuid="+menuid,function(data){
            //1、遍历每一个权限，在ztree中选中对应的节点
            $.each(data,function(){
                console.log(this);
                var treeObj = $.fn.zTree.getZTreeObj("assignPermissionTree");
                var node = treeObj.getNodeByParam("id", this.id, 0); //根据指定的节点id搜索节点，null表示搜索整个树
                treeObj.checkNode(node,true,false);//需要回显的节点，是否勾选复选框，父子节点勾选是否联动（例如：勾选父节点，要不要把它的所有子节点都勾上，取消父节点勾选，要不要把它的所有子节点也都取消勾选）
            });
        });
    }

</script>
</body>
</html>

