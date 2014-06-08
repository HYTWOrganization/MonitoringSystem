using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Collections;
using System.Net;
using System.Diagnostics;
using MonitoringSystem.Models;
//using System.Management;

namespace MonitoringSystem.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        PerformanceCounter _oPerformanceCounter;

        public HomeController()
        { 
            _oPerformanceCounter = new PerformanceCounter("Processor", "% Processor Time", "_Total");
        }
        
        public ActionResult Index()
        {
            ViewData["Message"] = "Welcome! There is basic information.";
            return View();
        }

        public ActionResult Welcome()
        {
            return View();
        }

        public ActionResult SystemInfo()
        {
            ViewData["Message"] = "Welcome! There is basic information.";
            ViewData["HostName"] = getComputerName();
            ArrayList ipList = getIpAddress();
            if (ipList.Count == 1)
            {
                ViewData["Ipv4"] = ipList[0].ToString();
                ViewData["Ipv6"] = "None";
            }
            else
            {
                ViewData["Ipv4"] = ipList[0].ToString();
                ViewData["Ipv6"] = ipList[1].ToString();
            }
            return View();
        }

        public ActionResult Memory()
        {
            return View();
        }

        public ActionResult ProcessInfo()
        {
            return View();
        }

        public ActionResult HardDisk()
        {
            return View();
        }

        public ContentResult GetCPUInfo()
        {
			
			//float _nVal=_oPerformanceCounter.NextValue();
			//_nVal中就是当前CPU的使用率了，加上百分号(%)就是使用率的百分比，比如：
			//string _s="当前CPU使用率：" + nVal.ToString("0.0") + "%";
            //string userHeader"25"Msg = Convert.ToString(Request.Headers["userHeader"]);
            //return Content(_nVal.ToString());
            string cpuValue = HomeModel.GetCPUInfo();
            return Content(cpuValue);
        }


        public ActionResult CPUInfo()
        {
            return View();
        }

        //get the IP address
        public ArrayList getIpAddress()
        {
            ArrayList ipList = new ArrayList();
            IPHostEntry ipe = Dns.GetHostEntry(Dns.GetHostName());
            for (int i = 0; i < ipe.AddressList.Length; i++)
            {
                ipList.Add(ipe.AddressList[i].ToString());
            }
            return ipList;
        }

        //get the computer name
        public string getComputerName()
        {
            return Dns.GetHostName();
        }
    }
}
