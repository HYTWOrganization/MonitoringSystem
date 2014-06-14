<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>
<script type="text/javascript">
    Ext.define('JKXT.HandleProcess', {

    });
</script>
<script type="text/javascript">
    Ext.onReady(function () {
        Ext.define('ProcessUsage', {
            extend: 'Ext.data.Model',
            fields: ['process', 'name', 'cpu', 'memory', 'description']
        });

        var store = Ext.create('Ext.data.Store', {
            storeId: 'processStore',
            model: 'ProcessUsage',
            proxy: {
                type: 'ajax',
                url: 'Process/GetData',
                reader: {
                    type: 'json',
                    root: 'ProcessUsage'
                }
            },
            autoLoad:true
        });

        var panel = Ext.create('Ext.grid.Panel', {
            title: 'Process Informaiton',
            store: store, //Ext.data.StoreManager.lookup('processStore'),
            columns: [
                { text: 'Process', dataIndex: 'process', width: 200 },
                { text: 'Name', dataIndex: 'name' },
                { text: 'CPU', dataIndex: 'cpu', align: 'right' },
                { text: 'Memory', dataIndex: 'memory', align: 'right' },
                { text: 'Description', dataIndex: 'description', flex: 1 }
            ],
            height: 200,
            width: 400,
            renderTo: Ext.getBody()
        });

        JKXT.center.add(panel);

        setInterval(function () {
            store.reload();
        }, 20000);  //20seconds
    });
</script>
<div>
    
</div>
