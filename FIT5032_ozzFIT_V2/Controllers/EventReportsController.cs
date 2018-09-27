using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using FIT5032_ozzFIT_V2.Models;

namespace FIT5032_ozzFIT_V2.Controllers
{
    public class EventReportsController : Controller
    {
        private UserDatabaseModel1Container db = new UserDatabaseModel1Container();

        // GET: EventReports
        public ActionResult Index()
        {
            return View(db.EventReports.ToList());
        }

        // GET: EventReports/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EventReport eventReport = db.EventReports.Find(id);
            if (eventReport == null)
            {
                return HttpNotFound();
            }
            return View(eventReport);
        }

        // GET: EventReports/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: EventReports/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "EventReportId,EventName,ReportDescription,ReportMedia")] EventReport eventReport)
        {
            if (ModelState.IsValid)
            {
                db.EventReports.Add(eventReport);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(eventReport);
        }

        // GET: EventReports/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EventReport eventReport = db.EventReports.Find(id);
            if (eventReport == null)
            {
                return HttpNotFound();
            }
            return View(eventReport);
        }

        // POST: EventReports/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "EventReportId,EventName,ReportDescription,ReportMedia")] EventReport eventReport)
        {
            if (ModelState.IsValid)
            {
                db.Entry(eventReport).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(eventReport);
        }

        // GET: EventReports/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            EventReport eventReport = db.EventReports.Find(id);
            if (eventReport == null)
            {
                return HttpNotFound();
            }
            return View(eventReport);
        }

        // POST: EventReports/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            EventReport eventReport = db.EventReports.Find(id);
            db.EventReports.Remove(eventReport);
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
    }
}
