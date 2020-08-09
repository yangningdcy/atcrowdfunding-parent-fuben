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


    <!-- 权限添加模态框Modal -->
    <div class="modal fade" id="AddModal" tabindex="-1" role="dialog" aria-labelledby="AddModal">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
                    <h4 class="modal-title" id="myModalLabel">添加权限</h4>
                </div>
                <form id="addPermissionForm">
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="addFormPid">权限名称</label>
                            <input type="hidden" id="addFormPid" name="pid" >
                            <input type="text" class="form-control" id="addFormTitle" name="tile"  placeholder="请输入权限名称">
                        </div>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="addFormIcon">权限图标</label>
                            <input type="text" class="form-control" id="addFormIcon" name="icon"  placeholder="请输入权限图标">
                        </div>
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <label for="addFormName">权限URL</label>
                            <input type="text" class="form-control" id="addFormName" name="name"  placeholder="请输入权限URL">
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" onclick="savePermission()">保存</button>
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
                <h4 class="modal-title" id="myModalLabel1">修改权限</h4>
            </div>
            <form id="addMenuForm1">


                <div class="modal-body">
                    <div class="form-group">
                        <label for="addFormName1">权限名称</label>
                        <input type="hidden" id="addFormId" name="id" >
                        <input type="text" class="form-control" id="addFormName1" name="title"  placeholder="请输入权限名称">
                    </div>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addFormIcon1">权限图标</label>
                        <input type="text" class="form-control" id="addFormIcon1" name="icon"  placeholder="请输入权限图标">
                    </div>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="addFormUrl1">权限URL</label>
                        <input type="text" class="form-control" id="addFormUrl1" name="name"  placeholder="请输入菜单URL">
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="updatePermission()">修改</button>
                </div>
            </form>
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
        initTree();

        /*alert($(".bb").html());*/

    });

/*
    $(function(){
        initTree();
    });*/

    function initTree(){
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
            view: {
                addDiyDom: addDiyDom,
                addHoverDom: addHoverDom, //显示按钮
                removeHoverDom: removeHoverDom //移除按钮
            }
        };

//1.加载数据
        $.get("${PATH}/permission/listAllPermissionTree",function(data){
            data.push({"id":0,"title":"系统权限","icon":"glyphicon glyphicon-asterisk"});
            var tree = $.fn.zTree.init($("#treeDemo"), setting, data);
            var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
            treeObj.expandAll(true);
        });
    }

    function addDiyDom(treeId,treeNode){
//console.log(treeNode);
//$("#"+treeNode.tId+"_ico").removeClass().addClass(treeNode.icon);
        $("#"+treeNode.tId+"_ico").removeClass();
        $("#"+treeNode.tId+"_span").before('<span class="'+treeNode.icon+'"></span>');
    }
    var id1;
    function addHoverDom(treeId,treeNode){
        var aObj = $("#" + treeNode.tId + "_a");
        aObj.attr("href", "#");
        aObj.attr("onclick", "return false;");//禁用单击事件
        if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
        var s = '<span id="btnGroup'+treeNode.tId+'">';
        id1=treeNode.id;
        if ( treeNode.level == 0 ) {
            s += '<a   class="plusBtn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn(id1)" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
        } else if ( treeNode.level == 1 ) {

            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn(id1)" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
            if (treeNode.children.length == 0) {
                s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn(id1)" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
            }
            s += '<a  class="plusBtn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="addBtn(id1)" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
        } else if ( treeNode.level == 2 ) {
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;"  onclick="updateBtn(id1)" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
            s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteBtn(id1)" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
        }
        s += '</span>';
        aObj.after(s);
    }

    function removeHoverDom(treeId,treeNode){
        $("#btnGroup"+treeNode.tId).remove();
    }






    //权限增删改
    function addBtn(id){
        $("#addFormPid").val(id);
        $("#AddModal").modal({show:true,backdrop:'static',keyboard:false})
    }

    function savePermission(){
        var pid = $("#addFormPid").val();
        var name = $("#addFormName").val();
        var icon = $("#addFormIcon").val();
        var title = $("#addFormTitle").val();
        $.post("${PATH}/permission/add",{pid:pid,name:name,icon:icon,title:title},function(result){
            if(result=="ok"){
                $("#AddModal").modal("hide");
                initTree();
            }
        });
        $("#addPermissionForm")[0].reset();
    }

    function updateBtn(id){
        $.get("${PATH}/permission/get",{id:id},function(result){
            $("#UpdateModal input[name='id']").val(result.id);
            $("#UpdateModal input[name='name']").val(result.name);
            $("#UpdateModal input[name='icon']").val(result.icon);
            $("#UpdateModal input[name='title']").val(result.title);
            $("#UpdateModal").modal({show:true,backdrop:'static',keyboard:false})
        });
    }

    function deleteBtn(id){
        layer.confirm("确定要删除这个许可吗?",{btn:["确定","取消"]},function(index){
            $.post("${PATH}/permission/delete",{id:id,_method:"delete"},function(result){
                if(result=="ok"){
                    initTree();
                }
            });
            layer.close(index);
        },function(index){
            layer.close(index);
        });
    }

    function updatePermission(){
        var id = $("#UpdateModal input[name='id']").val();
        var name = $("#UpdateModal input[name='name']").val();
        var icon = $("#UpdateModal input[name='icon']").val();
        var title = $("#UpdateModal input[name='title']").val();
        $.post("${PATH}/permission/edit",{id:id,name:name,icon:icon,title:title},function(result){
            if(result=="ok"){
                $("#UpdateModal").modal("hide");
                initTree();
            }
        });
    }

</script>
</body>
</html>

