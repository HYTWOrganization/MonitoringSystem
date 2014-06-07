using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace MonitoringSystem.Models
{
    public class ProcessModels
    {
        public string process { get; set; }
        public string name { get; set; }
        public string cpu { get; set; }
        public int memory { get; set; }
        public string description { get; set; }
    }
}