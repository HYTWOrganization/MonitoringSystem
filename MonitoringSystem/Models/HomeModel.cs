using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Diagnostics;
using System.Management;
using System.Threading;
using System.Resources;
using System.Globalization;

namespace MonitoringSystem.Models
{
    public class HomeModel
    {
        public static PerformanceCounter _oPerformanceCounter = new PerformanceCounter("Processor", "% Processor Time", "_Total");
        //protected ResourceManager LocRM;
        public HomeModel()
        {
           // Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(Request.UserLanguages[0]);
           // Thread.CurrentThread.CurrentUICulture = new CultureInfo(Request.UserLanguages[0]);
           // LocRM = new ResourceManager("HandleSystemInfo.strings", typeof(SystemInfo).Assembly);

        }
        public static string GetCPUInfo()
        {
            
            float _nVal = _oPerformanceCounter.NextValue();
            //_nVal中就是当前CPU的使用率了，加上百分号(%)就是使用率的百分比，比如：
            //string _s="当前CPU使用率：" + nVal.ToString("0.0") + "%";
            //string userHeader"25"Msg = Convert.ToString(Request.Headers["userHeader"]);
            return _nVal.ToString();
        }
    }
}