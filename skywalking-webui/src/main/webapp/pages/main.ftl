<#import "./common/commons.ftl" as common>
<#import "./common/traceInfo.ftl" as traceInfo>
<#import "./usr/applications/applicationMaintain.ftl" as applicationMaintain>
<#import "./usr/authfile/auth.ftl" as auth>
<!DOCTYPE html>
<html lang="zh-CN">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
<@common.importResources />
    <script src="${_base}/bower_components/jquery-ui/jquery-ui.min.js"></script>
    <link rel="stylesheet" href="${_base}/bower_components/jquery-treetable/css/jquery.treetable.theme.default.css"/>
    <script src="${_base}/bower_components/jquery-treetable/jquery.treetable.js"></script>
    <link href="${_base}/bower_components/jquery-treetable/css/jquery.treetable.css" rel="stylesheet"/>
    <link href="${_base}/bower_components/skywalking/css/tracelog.css" rel="stylesheet"/>
    <script src="${_base}/bower_components/skywalking/js/tracelog.js"></script>
    <script src="${_base}/bower_components/skywalking/js/application.js"></script>
    <link href="${_base}/bower_components/bootstrap-toggle/css/bootstrap-toggle.min.css" rel="stylesheet">
    <script src="${_base}/bower_components/bootstrap-toggle/js/bootstrap-toggle.min.js"></script>
</head>

<body style="padding-top:80px">
<@common.navbar/>
<!--Trace Info -->
<@traceInfo.traceTableTmpl/>
<@traceInfo.traceLogTmpl/>
<@traceInfo.traceTreeAllTmpl/>
<!--Application -->
<@applicationMaintain.applicationList/>
<@applicationMaintain.addApplication/>
<@applicationMaintain.createglobalConfig/>
<@applicationMaintain.modifyApplication/>
<@auth.downloadAuth/>
<p id="baseUrl" style="display: none">${_base}</p>
<div class="container" id="mainPanel">
    <p id="searchType" style="display: none">${searchType!''}</p>
    <p id="loadType" style="display: none;">${loadType!''}</p>
</div>

<script>
    $(document).ready(function () {
        //
        var loadType = $("#loadType").text();
        loadContent(loadType);
        // bind
        $("#searchBtn").click(function () {
            loadTraceTreeData("${_base}");
        })
    });

    function loadContent(loadType,applicationId){

        if (loadType == "showTraceInfo"){
            loadTraceTreeData("${_base}");
        }

        if (loadType == "applicationList") {
            loadAllApplications();
            return;
        }

        if (loadType == "addApplication"){
            var template = $.templates("#addApplicationTmpl");
            var htmlOutput = template.render({});
            $("#mainPanel").empty();
            $("#mainPanel").html(htmlOutput);
            addApplication();
            return;
        }

        if (loadType == "createGlobalApplication"){
            var template = $.templates("#createGlobalConfigTmpl");
            var htmlOutput = template.render({});
            $("#mainPanel").empty();
            $("#mainPanel").html(htmlOutput);
            createGlobalConfig();
            return;
        }

        if (loadType == "modifyApplication"){
            var template = $.templates("#modifyApplicationTmpl");
            var htmlOutput = template.render({applicationId:applicationId});
            $("#mainPanel").empty();
            $("#mainPanel").html(htmlOutput);
            modifyApplication();
            return;
        }

        if (loadType == "downloadAuthFile"){
            var template = $.templates("#downloadAuthFileTmpl");
            var htmlOutput = template.render({applicationCode:applicationId});
            $("#mainPanel").empty();
            $("#mainPanel").html(htmlOutput);
            toDownloadAuthFile();
            return;
        }

        $("#mainPanel").empty();
    }
</script>
</body>
</html>
