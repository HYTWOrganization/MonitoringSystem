<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>


<script type="text/javascript">
    Ext.onReady(function () {
        alert("hello");
        /*Ext.define('Memory', {
            extend: 'Ext.data.Model',
            fields: [
                 { name: 'memory', type: 'int' }
             ]
        });*/

        /*var myStore = Ext.create('Ext.data.Store', {
            model: 'Memory',
            proxy: {
                type: 'ajax',
                url: '/mem.json',
                reader: {
                    type: 'json',
                    root: 'mem'
                }
            },
            autoLoad: true
        });*/

        /*store1.loadData(generateData(8));
        var chart = Ext.create('Ext.chart.Chart', {
            style: 'background:#fff',
            animate: true,
            store: memStore,
            shadow: true,
            theme: 'Category1',
            legend: {
                position: 'right'
            },
            renderTo: 'memory-chart',
            axes: [{
                type: 'Numeric',
                minimum: 0,
                position: 'left',
                fields: ['data1', 'data2', 'data3'],
                title: 'Number of Hits',
                minorTickSteps: 1,
                grid: {
                    odd: {
                        opacity: 1,
                        fill: '#ddd',
                        stroke: '#bbb',
                        'stroke-width': 0.5
                    }
                }
            }, {
                type: 'Category',
                position: 'bottom',
                fields: ['name'],
                title: 'Month of the Year'
            }],
            series: [{
                type: 'line',
                highlight: {
                    size: 7,
                    radius: 7
                },
                axis: 'left',
                xField: 'name',
                yField: 'data1',
                markerConfig: {
                    type: 'cross',
                    size: 4,
                    radius: 4,
                    'stroke-width': 0
                }
            }, {
                type: 'line',
                highlight: {
                    size: 7,
                    radius: 7
                },
                axis: 'left',
                smooth: true,
                xField: 'name',
                yField: 'data2',
                markerConfig: {
                    type: 'circle',
                    size: 4,
                    radius: 4,
                    'stroke-width': 0
                }
            }, {
                type: 'line',
                highlight: {
                    size: 7,
                    radius: 7
                },
                axis: 'left',
                smooth: true,
                fill: true,
                xField: 'name',
                yField: 'data3',
                markerConfig: {
                    type: 'circle',
                    size: 4,
                    radius: 4,
                    'stroke-width': 0
                }
            }]

        });*/
        Ext.define('MemoryUsage', {
            extend: 'Ext.data.Model',
            fields: ['memory', 'time']
        });

        var store = Ext.create('Ext.data.Store', {
            model: 'MemoryUsage',
            /*data: [
                { memory: 58, time: 1 },
                { memory: 63, time: 2 },
                { memory: 73, time: 3 },
                { memory: 78, time: 4 },
                { memory: 81, time: 5 }
            ],*/
            proxy: {
                type: 'ajax',
                url: 'Memory/GetData',
                reader: {
                    type: 'json',
                    root: 'MemoryUsage'
                }
            },
            autoLoad: true
        });

        var chart = Ext.create('Ext.chart.Chart', {
            renderTo: Ext.getBody(),
            width: 400,
            height: 300,
            store: store,
            axes: [
                {
                    title: 'Memory',
                    type: 'Numeric',
                    position: 'left',
                    fields: ['memory'],
                    minimum: 0,
                    maximum: 100
                },
                {
                    title: 'Time',
                    type: 'Numeric',
                    position: 'bottom',
                    fields: ['time'],
                    minimum: 1,
                    maximum: 8
                }
            ],
            series: [
                {
                    type: 'line',
                    xField: 'time',
                    yField: 'memory'
                }
            ]
        });
            JKXT.center.add(chart);
            setInterval(function () {
                store.reload();  
            }, 10000);  //10seconds
    });
</script>
<div id='memory-chart'>

</div>