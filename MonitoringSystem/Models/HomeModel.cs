using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Diagnostics;
using System.Management;

namespace MonitoringSystem.Models
{
    public class HomeModel
    {
        public static PerformanceCounter _oPerformanceCounter = new PerformanceCounter("Processor", "% Processor Time", "_Total");
       
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