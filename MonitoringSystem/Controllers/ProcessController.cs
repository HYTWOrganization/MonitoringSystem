using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Mvc;
using MonitoringSystem.Models;
using System.Diagnostics;
using System.Management;

namespace MonitoringSystem.Controllers
{
    public class ProcessController : Controller
    {
        public JsonResult GetData()
        {
            Process[] processes;
            processes = System.Diagnostics.Process.GetProcesses();
            Process pro;
            List<ProcessModels> list = new List<ProcessModels>();
            for (int i = 0; i < processes.Length; i++)
            {
                pro = processes[i];
                list.Add(new ProcessModels() { process = pro.ProcessName, name = GetProcessUserName(pro.Id), cpu = "00", memory = ConvertToStr(pro.WorkingSet64), description = pro.MainWindowTitle });
            }
            return Json(list, JsonRequestBehavior.AllowGet);
        }

        //convert the long type to string and convert the "byte" to "kb"
        private string ConvertToStr(long mem)
        {
            string memStr;
            memStr = (mem / 1024).ToString() + 'K';
            return memStr;
        }

        //get the user name of current process through the process ID
        private static string GetProcessUserName(int pid)
        {
            string name = null;
            
            SelectQuery sqry = new SelectQuery("Select * from Win32_Process WHERE processID = " + pid);
            ManagementObjectSearcher sch = new ManagementObjectSearcher(sqry);

            try
            {
                foreach (ManagementObject disk in sch.Get())
                {
                    ManagementBaseObject inPar = null;
                    ManagementBaseObject outPar = null;

                    inPar = disk.GetMethodParameters("GetOwner");
                    outPar = disk.InvokeMethod("GetOwner", inPar, null);
                    name = outPar["user"].ToString();
                    break;
                }
            }
            catch
            {
                name = "SYSTEM";
            }
            return name;
        }
    }
}