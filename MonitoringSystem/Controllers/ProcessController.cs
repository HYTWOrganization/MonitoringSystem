using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using MonitoringSystem.Models;

namespace MonitoringSystem.Controllers
{
    public class ProcessController : Controller
    {
        public JsonResult GetData()
        {
            IEnumerable<ProcessModels> list = new List<ProcessModels>{
                new ProcessModels(){ process = "abc.ext", name="zqs", cpu="00", memory=124,description="console"},
                new ProcessModels(){ process = "abc.ext", name="zqs", cpu="00", memory=124,description="console"}
            };
            return Json(list, JsonRequestBehavior.AllowGet);
        }
    }
}