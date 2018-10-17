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
    public class EventsController : Controller
    {
        private UserDatabaseModel1Container db = new UserDatabaseModel1Container();

        // GET: Events
        public ActionResult Index()
        {



            foreach (Event evenetTble in db.Events.ToList())
            {
                //evenetTble.IsLike = true;

                //if (evenetTble.IsLike)
                //{
                //    evenetTble.IsLike = false;
                //}
                //else
                //{
                //    evenetTble.IsLike = true;
                //}

                db.SaveChanges();
            }

            return View(db.Events.ToList());
        }

        // GET: Events/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            return View(@event);
        }

        // GET: Events/Create
        public ActionResult Create()
        {
            Event @event = new Event();
            @event.Likes = 0;
            return View(@event);
        }

        // POST: Events/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "EventId,EventName,EventDescription,Location,StartDateTime,EndDateTime,ContactPerson,ContactDetails,Likes,IsLike")] Event @event)
        {
            if (ModelState.IsValid)
            {
                db.Events.Add(@event);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(@event);
        }

        // GET: Events/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            return View(@event);
        }

        // POST: Events/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "EventId,EventName,EventDescription,Location,StartDateTime,EndDateTime,ContactPerson,ContactDetails,Likes,IsLike")] Event @event)
        {
            if (ModelState.IsValid)
            {
                db.Entry(@event).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(@event);
        }

        // GET: Events/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Event @event = db.Events.Find(id);
            if (@event == null)
            {
                return HttpNotFound();
            }
            return View(@event);
        }

        // POST: Events/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Event @event = db.Events.Find(id);
            db.Events.Remove(@event);
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

        public ActionResult Like(int id)
        {
            Event updateLike = db.Events.ToList().Find(u => u.EventId == id);

            //if(updateLike.Likes == 0)
            //{
            //    updateLike.Likes += 1;
            //    ViewData["IsEnabled"] = false;
            //    updateLike.IsLike = false;
            //}
            if (updateLike.IsLike)
            {
                updateLike.Likes += 1;

                updateLike.IsLike = true;
                

            }
            else
            {
                updateLike.Likes -= 1;

                updateLike.IsLike = false;

            }
            
            db.SaveChanges();
            return RedirectToAction("Index");
        }

    }
}
