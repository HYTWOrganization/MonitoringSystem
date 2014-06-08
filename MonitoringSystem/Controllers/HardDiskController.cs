using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MonitoringSystem.Models;

namespace MonitoringSystem.Controllers
{
    public class HardDiskController : Controller
    {
        //
        // GET: /HardDisk/

        public JsonResult GetData()
        {
            List<DiskModels> list = new List<DiskModels>();
            list.Add(new DiskModels() { name = "C disk", data = 10 });
            list.Add(new DiskModels() { name = "D disk", data = 20 });
            list.Add(new DiskModels() { name = "E disk", data = 30 });
            list.Add(new DiskModels() { name = "F disk", data = 40 });
            return Json(list, JsonRequestBehavior.AllowGet);
        }

    }
}
