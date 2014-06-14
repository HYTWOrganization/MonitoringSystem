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

        genData: function () {
            var memObj1 = Ext.create('JKXT.HandleMemory', "handleMemory");
            var data = [], i = 0,
                last = false,
                date = startDate;
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
                    time: Ext.Date.add(date, Ext.Date.SECOND, i),
                    memory: memValue

                });
                i = i + 10;
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

        startDate = new Date();
        endDate = Ext.Date.add(startDate, Ext.Date.MINUTE, 5);

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
                    type: 'Time',
                    position: 'bottom',
                    field: 'time',
                    title: 'Time',
                    step: [Ext.Date.SECOND, 10], 
                    dateFormat: 'H:i:s',
                    groupBy: 'hour,minute,second', //精确度
                    aggregateOp: 'sum',
                    constrain: true,
                    //minimum: 1,
                    //maximum: 30
                    fromDate: startDate,
                    toDate: endDate,
                    grid: true
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

        var iii=1;
        setInterval(function () {
            iii = iii + 1;
            var gs = generateData();
            var max = timeAxis.toDate,
                lastTime = gs[gs.length - 1].time,
                markerIndex = chart.markerIndex || 0;
            if (+max < +lastTime) {
                markerIndex = 1;
                timeAxis.toDate = lastTime;
                timeAxis.fromDate = Ext.Date.add(Ext.Date.clone(timeAxis.fromDate), Ext.Date.SECOND, 10);
                //timeAxis.minimum++;
                chart.markerIndex = markerIndex;
            }
            store.loadData(gs);
        }, 10000);  //10seconds
    });
</script>
<div id='memory-chart'>

</div>