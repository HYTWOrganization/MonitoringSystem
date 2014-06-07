<%@ Page Language="C#" Inherits="System.Web.Mvc.ViewPage" %>

<script type="text/javascript">
    Ext.define('JKXT.HandleMemory', {
        name: 'unknown',
        constructor: function (name) {
            if (name) {
                this.name = name;
            }
        },
        getMemValue: function () {
            var retValue = 0;
            Ext.Ajax.request({
                url: 'Memory/GetMemoryValue',  //get the memory rate
                method: 'GET',
                type: 'text/html',
                async: false,
                success: function (response, options) {
                    retValue = Number(response.responseText);
                    return retValue;
                },
                failure: function (response, options) {
                    Ext.MessageBox.alert('失败', '错误编号：' + response.status);
                    return 0;
                }
            });
            return retValue;
        },

        regroup: function () {
            group = !group;
            var axis = chart.axes.get(1),
            selectedGroup = groupOp[+group];
            axis.dateFormat = selectedGroup.dateFormat;
            axis.groupBy = selectedGroup.groupBy;
            chart.redraw();
        },

        genData: function () {
            var memObj1 = Ext.create('JKXT.HandleMemory', "handleMemory");
            var data = [], i = 0,
                last = false,
                date = new Date("April 2 2013 10:10:1"),
                seconds = +date,
                min = Math.min,
                max = Math.max,
                random = Math.random;
            memValue = 0;
            return function () {
                data = data.slice();
                memValue = memObj1.getMemValue();
                if (data.length == 30)
                    data.splice(0, 1);
                data.push({
                    time: ++i, 
                    memory: memValue

                });
                last = data[data.length - 1];
                return data;
            };
        }


    });
</script>
<script type="text/javascript">
    Ext.onReady(function () {
        Ext.define('MemoryUsage', {
            extend: 'Ext.data.Model',
            fields: ['memory', 'time']
        });

        var memObj = Ext.create('JKXT.HandleMemory', "handleMemory");
        var generateData = memObj.genData();

        var store = Ext.create('Ext.data.Store', {
            model: 'MemoryUsage',
            /*proxy: {
            type: 'ajax',
            url: 'Memory/GetData',
            reader: {
            type: 'json',
            root: 'MemoryUsage'
            }
            },*/
            data: generateData(),
            autoLoad: true
        });

        var chart = Ext.create('Ext.chart.Chart', {
            renderTo: Ext.getBody(),
            width: 400,
            height: 300,
            theme: 'Category1',
            style: 'background:#fff',
            animate: true,
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
                    type: 'Numeric',
                    position: 'bottom',
                    field: 'time',
                    title: 'Time',
                    minimum: 1,
                    maximum: 30
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
        var timeAxis = chart.axes.get(1); ;
        JKXT.center.add(chart);
        setInterval(function () {
            var gs = generateData();
            var max = timeAxis.maximum,
                lastTime = gs[gs.length - 1].time,
                markerIndex = chart.markerIndex || 0;
            if (+max < +lastTime) {
                markerIndex = 1;
                timeAxis.maximum = lastTime;
                timeAxis.minimum++;
                chart.markerIndex = markerIndex;
            }
            store.loadData(gs);
        }, 10000);  //10seconds
    });
</script>
<div id='memory-chart'>

</div>