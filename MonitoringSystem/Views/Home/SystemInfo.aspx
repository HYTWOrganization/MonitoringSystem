<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<div>
    <h2>Basic Information</h2>
    <p>
        Computer Name: <%= Html.Encode(ViewData["HostName"] )%>
        <a href="http://asp.net/mvc" title="ASP.NET MVC 网站">http://asp.net/mvc</a>。
    </p>
    <p>
        Ipv4 Address: <%= Html.Encode(ViewData["Ipv4"]) %>
    </p>
    <p>
        Ipv6 Address: <%= Html.Encode(ViewData["Ipv6"]) %>
    </p>
</div>