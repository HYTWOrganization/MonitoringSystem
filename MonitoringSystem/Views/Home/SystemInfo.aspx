<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<html>
<!--<div>
    <h2>Basic Information</h2>
    <p>
        Computer Name: <%= Html.Encode(ViewData["HostName"] )%>
    </p>
    <p>
        Ipv4 Address: <%= Html.Encode(ViewData["Ipv4"]) %>
    </p>
    <p>
        Ipv6 Address: <%= Html.Encode(ViewData["Ipv6"]) %>
    </p>
</div>-->
</html>
<script type = "javascript">
Ext.onReady(getInfo);

function getInfo() {
    var panel = new Ext.Panel({
        title: "System Info",
        layout: "table",
        width: 500,
        height: 300,
        bodyStyle:'padding:20px;',
        bodyStyle:'padding:10 10 10 10',
        layoutConfig: {
            //columns: 3
            rows:3
        },
        items: [
            {xtype:"panel", title:"Computer Name", html:'<%= Html.Encode(ViewData["HostName"] )%>', width:200},
            {xtype:"panel", title:"IPv4", html:"<%= Html.Encode(ViewData["Ipv4"]) %>", width:200},
            {xtype:"panel", title:"IPv6", html:"<%= Html.Encode(ViewData["Ipv6"]) %>", width:200}
        ]
    });
    JKXT.center.add(panel); 
    //panel.render(Ext.getDom("tt"));
}

</script>