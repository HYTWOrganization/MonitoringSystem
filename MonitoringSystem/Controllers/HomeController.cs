using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Collections;
using System.Net;

namespace MonitoringSystem.Controllers
{
    [HandleError]
    public class HomeController : Controller
    {
        public ActionResult Index()
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
