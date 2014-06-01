<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="aboutTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Memory Usage
</asp:Content>

<asp:Content ID="aboutContent" ContentPlaceHolderID="MainContent" runat="server">
    <script type="text/javascript">
        Ext.require([
            'Ext.chart.*',
            'Ext.Window',
            'Ext.fx.target.Sprite',
            'Ext.layout.container.Fit',
            'Ext.window.MessageBox'
        ]);
        Ext.onReady(function () {
            var chart = Ext.create('Ext.chart.Chart',{
            });
            var win = Ext.create('Ext.Window',{
                width: 800,
                height: 600,
                title: 'Line chart',
                hidden: false,
                renderTo: Ext.getBody(),
                layout: 'fit',
                items:chart
            });
            win.show();
        });
    </script>
</asp:Content>
