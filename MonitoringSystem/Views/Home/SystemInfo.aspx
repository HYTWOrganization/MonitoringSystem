<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<html>
<div>
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
</div>
</html>