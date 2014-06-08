using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MonitoringSystem.Models;
using System.Management;

namespace MonitoringSystem.Controllers
{
    public class HardDiskController : Controller
    {
        private const long MB = 1048576;

        //
        // GET: /HardDisk/
        public JsonResult GetData()
        {
            List<DiskModels> list = new List<DiskModels>();
            String diskname, desp;
            long totalspace, freespace, usedspace;
            ManagementClass diskClass = new ManagementClass("Win32_LogicalDisk");
            ManagementObjectCollection disks = diskClass.GetInstances();
            foreach (ManagementObject disk in disks)
            {
                try
                {
                    //disk name
                    diskname = disk["Name"].ToString();
                    //disk description
                    desp = disk["Description"].ToString();
                    //disk total space, available space, used space
                    if (System.Convert.ToInt64(disk["Size"]) > 0)
                    {
                        totalspace = System.Convert.ToInt64(disk["Size"]) / MB;
                        freespace = System.Convert.ToInt64(disk["FreeSpace"]) / MB;
                        usedspace = totalspace - freespace;
                        list.Add(new DiskModels() { name = diskname + totalspace + " MB\nUsed Space:" + usedspace + " MB", data = totalspace });
                    }
                }
                catch
                {
                }
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

    }
}
