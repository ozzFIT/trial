using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FIT5032_ozzFIT_V2.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;

namespace FIT5032_ozzFIT_V2.Controllers
{
    public class ConsultationsController : Controller
    {
        private UserDatabaseModel1Container db = new UserDatabaseModel1Container();
        private UserManager<ApplicationUser> _userManager;

        public ConsultationsController()
        {

        }

        public ConsultationsController(UserManager<ApplicationUser> userManager)
        {
            _userManager = userManager;
        }
        // GET: Consultations
        public ActionResult Index()
        {
            var consultations = db.Consultations.Include(c => c.User);
            return View(consultations.ToList());
        }

        // GET: Consultations/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Consultation consultation = db.Consultations.Find(id);
            if (consultation == null)
            {
                return HttpNotFound();
            }
            return View(consultation);
        }

        // GET: Consultations/Create
        public ActionResult Create()
        {
            ViewBag.UserUserId = new SelectList(db.Users, "UserId", "FirstName");
            return View();
        }

        // POST: Consultations/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ConsultationId,StartDT,EndDT,RDescription,Status,UserUserId")] Consultation consultation)
        {
            if (ModelState.IsValid)
            {
                db.Consultations.Add(consultation);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.UserUserId = new SelectList(db.Users, "UserId", "FirstName", consultation.UserUserId);
            return View(consultation);
        }

        // GET: Consultations/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Consultation consultation = db.Consultations.Find(id);
            if (consultation == null)
            {
                return HttpNotFound();
            }
            ViewBag.UserUserId = new SelectList(db.Users, "UserId", "FirstName", consultation.UserUserId);
            return View(consultation);
        }

        // POST: Consultations/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ConsultationId,StartDT,EndDT,RDescription,Status,UserUserId")] Consultation consultation)
        {
            if (ModelState.IsValid)
            {
                db.Entry(consultation).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.UserUserId = new SelectList(db.Users, "UserId", "FirstName", consultation.UserUserId);
            return View(consultation);
        }

        // GET: Consultations/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Consultation consultation = db.Consultations.Find(id);
            if (consultation == null)
            {
                return HttpNotFound();
            }
            return View(consultation);
        }

        // POST: Consultations/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Consultation consultation = db.Consultations.Find(id);
            db.Consultations.Remove(consultation);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }


        // GET: Consultations/GetAppointments
        public ActionResult GetAppointments()
        {
            Consultation consultation = new Consultation();

            var id = User.Identity.GetUserId();
            //ApplicationUser user = HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>().FindById(id);

            int userId = 1;
            foreach (User userTble in db.Users.ToList())
            {
                if (userTble.Email == User.Identity.Name)
                {
                    userId = userTble.UserId;
                    break;
                }

            }
            //Consultation matchId = db.Consultations.FirstOrDefault(i => i.UserId == userId);
            //var items = db.Items.Where(i => i.typeID == 1);
            return Json(db.Consultations.Where(i => i.UserUserId == userId).AsEnumerable().Select(e => new
            {
                id = e.ConsultationId,
                title = e.RDescription,
                start = Convert.ToDateTime(e.StartDT),
                end = Convert.ToDateTime(e.EndDT),
                description = (e.Status)
            }).ToList(), JsonRequestBehavior.AllowGet);

            // }
        }

        //POST - Appointment saved 
        [HttpPost]
        public ActionResult SaveAppointment(Consultation eventData)
        {
            var id = User.Identity.GetUserId();
            //ApplicationUser user = HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>().FindById(id);
            //int userId = db.Users
            //                  .Where(x => x.Email == User.Identity.Name)
            //                  .Select(x => x.UserId)
            //                  .Single();
            int userId = 1;
            foreach (User userTble in db.Users.ToList())
            {
                if (userTble.Email == User.Identity.Name)
                {
                    userId = userTble.UserId;
                    break;
                }

            }
            eventData.UserUserId = userId;

            db.Consultations.Add(eventData);
            db.SaveChanges();
            return Json(new { success = true }, JsonRequestBehavior.AllowGet);

        }

    }
}
