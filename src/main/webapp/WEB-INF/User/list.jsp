<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/3/30
  Time: 9:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>users</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/css/bootstrap.min.css" />
    <script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/jquery-1.12.4.js"></script>
    <script type="text/javascript" src="${pageContext.servletContext.contextPath}/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        /**
         *  totalPage指总页数
         *  currentPage: 当前页
         *  hasPrevPage: 是否有上一页
         *  hasNextPage: 是否有下一页
         *  url: 点击翻页的地址
         *  roundNum: 左右展示多少页
         */
        function generatePager(totalPage, currentPage, hasPrevPage, hasNextPage, url, roundNum) {
            var $html = $("<ul class='pagination' style='margin-top:0;'>");

            if(hasPrevPage) {  //如果有上一页，拼接上一页的按钮
                $html.append(generateFirstOrLastTag(url, true, false, currentPage));
            }

            var beginIndex, endIndex;  //定义生成按钮的的索引，主要针对当前页标签，以及当前页前后的标签
            if((currentPage - roundNum) >= 2) {  //有点
                $html.append(generatePageTag(url, 0, 1, false));  //生成第一页的信息
                $html.append(generateDotTag());  //
                beginIndex = currentPage - roundNum;
            }else{
                beginIndex = 0;
            }

            if((totalPage - (currentPage + roundNum)) > 2) {  //有点
                endIndex = currentPage + roundNum;
                $html.append(generateSpecifyIndexTag(currentPage, beginIndex, endIndex, url));
                $html.append(generateDotTag());  //生成带点的按钮
                $html.append(generatePageTag(url, totalPage - 1, totalPage, false)); //最后一页
            } else {
                endIndex = totalPage - 1;
                $html.append(generateSpecifyIndexTag(currentPage, beginIndex, endIndex, url));
            }

            if(hasNextPage) {
                $html.append(generateFirstOrLastTag(url, false, true, currentPage));
            }

            $html.append("</ul>");

            return $html[0];
        }

        /**
         循环生成翻页的标签
         */
        function generateSpecifyIndexTag(currentPage, beginIndex, endIndex, url){
            var htmlTag = "";
            for(var i = beginIndex; i <= endIndex; i++) {
                if(currentPage == i) {
                    htmlTag += generatePageTag(url, i, i + 1, true);
                }else{
                    htmlTag += generatePageTag(url, i, i + 1, false);
                }
            }
            return htmlTag;
        }

        /**
         * 生成首页或者尾页的按钮
         * prev: 是否有上一页
         * next: 是否有下一页
         */
        function generateFirstOrLastTag(url, prev, next, currentPage) {
            var view;   //toPage要到的页面, view为标签上展示的内容
            if(prev) { //如果有上一页
                currentPage--;  //上一页的值应该为
                view = "&laquo;";
            }
            if(next) {
                currentPage++;
                view = "&raquo;";
            }
            return generatePageTag(url, currentPage, view);
        }

        /**
         * url指的是翻页需要请求的地址
         * page是需要跳转到第几页
         * view为按钮上需要展示的文字
         * isCurrentPage: 因为当前页需要在li上指定 class="active"属性
         */
        function generatePageTag(url, page, view, isCurrentPage){
            var active = isCurrentPage ? " class='active'" : "";  //是否为当前页
            return "<li" + active + ">" +
                "<a href='" + url + "?pager=" + page + "'>" +
                view +
                "</a>" +
                "</li>";
        }

        //生成不可点击的三个点按钮
        function generateDotTag() {
            return "<li class='disabled'><a href='javascript:;'>...</a></li>";
        }

        //删除用户
        function deleteUser(userId) {
            location.href = "User_delete?id=" + userId + "&pager=" + ${requestScope.pager.number};
        }
    </script>
</head>
<body>
    <div class="container" style="margin-top: 20px;">
        <table class="table table-striped table-hover table-bordered">
            <thead>
            <tr>
                <th>ID</th>
                <th>姓名</th>
                <th>性别</th>
                <th>邮件</th>
                <th>生日</th>
                <th>创建日期</th>
                <th>修改日期</th>
                <th>公司名</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
                <!-- s:iterator遍历的标签，会将当前对象压入栈顶 -->
                <s:iterator value="#request.pager.content" var="u">
                    <tr>
                        <td>${u.id}</td>
                        <td>${u.name}</td>
                        <td>${u.gender}</td>
                        <td>${u.email}</td>
                        <td><s:date name="birthday" format="yyyy-MM-dd"></s:date></td>
                        <td><s:date name="createTime" format="yyyy-MM-dd HH:mm:ss"></s:date></td>
                        <td><s:date name="updateTime" format="yyyy-MM-dd HH:mm:ss"></s:date></td>
                        <td>${empty u.company ? "" : u.company.name}</td>
                        <td>
                            <a class="btn btn-primary btn-sm" href="javascript:;">编辑</a>
                            <a class="btn btn-danger btn-sm" href="User_delete?id=${u.id}&pager=${requestScope.pager.number}">删除</a>
                        </td>
                    </tr>
                </s:iterator>
            </tbody>
        </table>
        <div class="row">
            <div class="col-xs-6 col-xs-offset-4" id="pagination">
                <!-- js怎么去获取我们model中的信息， -->
                <script type="text/javascript">  <!-- 可以类似这种方式定义的javascript中获取thymeleaf的信息 -->
                $("#pagination").html(generatePager(${requestScope.pager.totalPages},
                    ${requestScope.pager.number}, ${!requestScope.pager.first}, ${!requestScope.pager.last}, "User_list", 2));
                </script>
            </div>
        </div>
    </div>
</body>
</html>
