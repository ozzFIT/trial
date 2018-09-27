using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FIT5032_ozzFIT_V2.Controllers
{
    
    public class HomeController : Controller
    {

        public ActionResult Index()
        {
            return View();
        }

        //[Authorize]
        public ActionResult About()
        {
            ViewBag.Message = "ozzFIT, Melbourne's best fitness solution";

            return View();
        }

        //[Authorize(Roles = "Administrators, RegisteredUser")]
        public ActionResult Contact()
        {
            ViewBag.Message = "Contact ozzFIT";

            return View();
        }

        public ActionResult Events()
        {
            return View();
        }
    }
}