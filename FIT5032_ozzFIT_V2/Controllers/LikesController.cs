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
    public class LikesController : Controller
    {
        private UserDatabaseModel1Container db = new UserDatabaseModel1Container();

        // GET: Likes
        public ActionResult Index()
        {
            return View(db.Likes.ToList());
        }

        // GET: Likes/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Likes likes = db.Likes.Find(id);
            if (likes == null)
            {
                return HttpNotFound();
            }
            return View(likes);
        }

        // GET: Likes/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Likes/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "LikeId,IsLike")] Likes likes)
        {
            if (ModelState.IsValid)
            {
                db.Likes.Add(likes);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(likes);
        }


        /* post likes code*/

        // This Method is Used To Post A like and Dislike    
        //public string Like(int id, bool status)
        //{
            
        //        //var thread = db.   //db.Threads.FirstOrDefault(x => x.ThreadID == id);
        //        var toggle = false;
        //        Likes like = db.Likes.FirstOrDefault(x => x.ThreadId == id && x.UserID == Helper.UserId);
        //        // here we are checking whether user have done like or dislike    
        //        if (like == null)
        //        {
        //            like = new Model.Like();
        //            like.UserID = Helper.UserId;
        //            like.IsLike = status;
        //            like.ThreadId = id;
        //            if (status)
        //            {
        //                if (thread.LikeCount == null) // if no one has done like or dislike and first time any one doing like and dislike then assigning 1 and                                                                                0    
        //                {
        //                    thread.LikeCount = thread.LikeCount ? ? 0 + 1;
        //                    thread.DislikeCount = thread.DislikeCount ? ? 0;
        //                }
        //                else
        //                {
        //                    thread.LikeCount = thread.LikeCount + 1;
        //                }
        //            }
        //            else
        //            {
        //                if (thread.DislikeCount == null)
        //                {
        //                    thread.DislikeCount = thread.DislikeCount ? ? 0 + 1;
        //                    thread.LikeCount = thread.LikeCount ? ? 0;
        //                }
        //                else
        //                {
        //                    thread.DislikeCount = thread.DislikeCount + 1;
        //                }
        //            }
        //            db.Likes.Add(like);
        //        }
        //        else
        //        {
        //            toggle = true;
        //        }
        //        if (toggle)
        //        {
        //            like.UserID = Helper.UserId;
        //            like.IsLike = status;
        //            like.ThreadId = id;
        //            if (status)
        //            {
        //                // if user has click like button then need to increase +1 in like and -1 in Dislike    
        //                thread.LikeCount = thread.LikeCount + 1;
        //                if (thread.DislikeCount == 0 || thread.DislikeCount < 0)
        //                {
        //                    thread.DislikeCount = 0;
        //                }
        //                else
        //                {
        //                    thread.DislikeCount = thread.DislikeCount - 1;
        //                }
        //            }
        //            else
        //            {
        //                // if user has click dislike then need to increase +1 in dislike and -1 in like    
        //                thread.DislikeCount = thread.DislikeCount + 1;
        //                if (thread.LikeCount == 0 || thread.LikeCount < 0)
        //                {
        //                    thread.LikeCount = 0;
        //                }
        //                else
        //                {
        //                    thread.LikeCount = thread.LikeCount - 1;
        //                }
        //            }
        //        }
        //        db.SaveChanges();
        //        return thread.LikeCount + "/" + thread.DislikeCount;
            
        //}




        /* post likes code*/

        // GET: Likes/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Likes likes = db.Likes.Find(id);
            if (likes == null)
            {
                return HttpNotFound();
            }
            return View(likes);
        }

        // POST: Likes/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "LikeId,IsLike")] Likes likes)
        {
            if (ModelState.IsValid)
            {
                db.Entry(likes).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(likes);
        }

        // GET: Likes/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Likes likes = db.Likes.Find(id);
            if (likes == null)
            {
                return HttpNotFound();
            }
            return View(likes);
        }

        // POST: Likes/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Likes likes = db.Likes.Find(id);
            db.Likes.Remove(likes);
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
