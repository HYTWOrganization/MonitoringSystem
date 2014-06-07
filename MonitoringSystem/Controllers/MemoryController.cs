using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MonitoringSystem.Models;
using System.Runtime.InteropServices;

namespace MonitoringSystem.Controllers
{
    public class MemoryController : Controller
    {
        //
        // GET: /Memory/
        public struct MEMORY_INFO { 
            public uint dwLength; 
            public uint dwMemoryLoad; 
            public uint dwTotalPhys; 
            public uint dwAvailPhys; 
            public uint dwTotalPageFile; 
            public uint dwAvailPageFile; 
            public uint dwTotalVirtual; 
            public uint dwAvailVirtual;    
        }        

        /*public JsonResult GetData()
        {
            IEnumerable<MemoryModels> list = new List<MemoryModels>{
                new MemoryModels(){ memory = GetMemoryValue(), time = 8},
                new MemoryModels(){ memory = GetMemoryValue(), time = 7},
                new MemoryModels(){ memory = GetMemoryValue(), time = 6},
                new MemoryModels(){ memory = GetMemoryValue(), time = 5},
                new MemoryModels(){ memory = GetMemoryValue(), time = 4},
                new MemoryModels(){ memory = GetMemoryValue(), time = 3},
                new MemoryModels(){ memory = GetMemoryValue(), time = 2},
                new MemoryModels(){ memory = GetMemoryValue(), time = 1}
            };
            return Json(list, JsonRequestBehavior.AllowGet);
        }*/

        public class getmemory {
            [DllImport("kernel32")]        
            public static extern void GlobalMemoryStatus(ref MEMORY_INFO meminfo);    
        }
   
        public int GetMemoryValue()
        {
            MEMORY_INFO MemInfo; 
            MemInfo = new MEMORY_INFO(); 
            getmemory.GlobalMemoryStatus(ref MemInfo); 
            int mem = (int)MemInfo.dwMemoryLoad;
            return mem;
        }
    }
}
