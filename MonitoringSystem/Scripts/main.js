JKXT = {
    north: new Ext.panel.Panel({
        region: 'north',
        contentEl: 'main-north',
        height: 100,
        html: '<h1>Computer Information Monitoring System</h1>',
        margins: '0 5 5 5'
    }),
    south: new Ext.panel.Panel({
        region: 'south',
        contentEl: 'main-south',
        height: 20,
        split: false,
        html: 'Welcome!',
        margins: '0 5 5 5'
    }),
    west: new Ext.panel.Panel({
        title: 'Menu',
        region: 'west',
        contentEl: 'main-west',
        margins: '5 0 0 5',
        width: 200,
        collapsible: true,
        id: 'west-region-container',
        layout: 'fit',
        items: []
    }),
    center: new Ext.panel.Panel({
        title: 'Content',
        region: 'center',
        contentEl: 'main-center',
        id: 'center',
        layout: 'fit',
        margins: '5 5 0 0',
        html: 'This is center'
    }),
    menuData: [
        {
            name: 'Welcome',
            href: 'Home/Welcome'
        }, {
            name: 'Basic Information',
            href: 'Home/SystemInfo'
        }, {
            name: 'CPU Usage',
            href: 'Home/CPUInfo'
        }, {
            name: 'Memory Usage',
            href: 'Home/Memory'
        }, {
            name: 'Process List',
            href: 'Home/ProcessInfo'
        }, {
            name: 'Hard Disk Usage',
            href: 'Home/HardDisk'
        }
    ],
    onMainLoadReady: Ext.emptyFn,
    mainPanelCallback: function () {
        JKXT.onMainLoadReady();
    },
    doAnchor: function (el) {
        Ext.get(el).on('click', function (e) {
            var target = e.getTarget('a', 3, true);
            if (target) {
                if (target.getAttributeNS("jkxt", "noajax"))
                    return;

                e.stopEvent();

                JKXT.mainPanelLoad(target.dom.href);

            }
        });
    },
    clearMainPanel: function () {
        //JKXT.onMainLoadReady = Ext.emptyFn;
        JKXT.center.removeAll();
    },
    mainPanelLoad: function (url) {
        JKXT.clearMainPanel();
        //JKXT.onMainLoadReady = Ext.emptyFn;
        Ext.get("center").mask('loading');
        JKXT.center.body.load({
            url: url,
            nocache: true,
            text: '载入中……',
            timeout: 30,
            scripts: true,
            callback: function () {
                //JKXT.mainPanelCallback();
            }
        });
        Ext.get("center").unmask();
        JKXT.center.doLayout();
    }
}

Ext.onReady(function () {
    //菜单显示
    var menuPanel = new Ext.Panel({
        region: 'center',
        bodyStyle: "background-color: white; padding: 0 4px",
        border: false
    });
    for (var i = 0; i < JKXT.menuData.length; i++) {
        var menuItem = new Ext.button.Button({
            width: 190,
            height: 50,
            scale: 'large',
            text: JKXT.menuData[i].name,
            href: JKXT.menuData[i].href,
            handler: function (btn,e) {
                e.stopEvent();
                Ext.Ajax.request({
                    url: btn.href,
                    method: 'get',
                    //type: 'text/html',
                    //async: false,
                    success: function (response) {
                        JKXT.mainPanelLoad(btn.href);
                    },
                    failure: function (response) {
                        alert("failure");
                    }
                });
            }
        });
        menuPanel.add(menuItem);
    }
    JKXT.west.add(menuPanel);
    JKXT.mainPanelLoad('Home/Welcome');
    /*JKXT.center.body.load({
            url: 'Home/Welcome',
            nocache: true,
            text: '载入中……',
            timeout: 30,
            scripts: true,
            callback: function () {
                //JKXT.mainPanelCallback();
            }
        });
        //Ext.get("center").unmask();
        JKXT.center.doLayout();*/
    //主界面显示
    var viewport = new Ext.Viewport({
        layout: 'border',
        renderTo: Ext.getBody(),
        items: [
			JKXT.north,
            JKXT.west,
            JKXT.center,
            JKXT.south
		]
    });
    /*Ext.Ajax.request({
                    url: 'Home/Welcome',
                    method: 'get',
                    //type: 'text/html',
                    //async: false,
                    success: function (response) {
                        JKXT.mainPanelLoad(btn.href);
                    },
                    failure: function (response) {
                        alert("failure");
                    }	*/
    
    //alert('end');
});

