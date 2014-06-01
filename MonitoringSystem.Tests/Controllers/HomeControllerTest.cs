using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using MonitoringSystem;
using MonitoringSystem.Controllers;

namespace MonitoringSystem.Tests.Controllers
{
    [TestClass]
    public class HomeControllerTest
    {
        [TestMethod]
        public void Index()
        {
            // 排列
            HomeController controller = new HomeController();

            // 操作
            ViewResult result = controller.Index() as ViewResult;

            // 断言
            ViewDataDictionary viewData = result.ViewData;
            Assert.AreEqual("Welcome! There is basic information.", viewData["Message"]);
        }

        [TestMethod]
        public void SystemInfo()
        {
            // 排列
            HomeController controller = new HomeController();

            // 操作
            ViewResult result = controller.SystemInfo() as ViewResult;

            // 断言
            ViewDataDictionary viewData = result.ViewData;
        }

        [TestMethod]
        public void About()
        {
            // 排列
            HomeController controller = new HomeController();

            // 操作
            ViewResult result = controller.Memory() as ViewResult;

            // 断言
            Assert.IsNotNull(result);
        }
    }
}
