<%@ Page Language="C#" Culture="auto" UICulture="auto" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Basic Information
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%= Html.Encode(ViewData["Message"]) %></h2>
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
</asp:Content>
