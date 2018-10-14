using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using FIT5032_ozzFIT_V2.Models;

namespace FIT5032_ozzFIT_V2.Controllers
{
    public class CommentsController : Controller
    {
        private UserDatabaseModel1Container db = new UserDatabaseModel1Container();

        // GET: Comments
        public ActionResult Index()
        {
            //var currentEvent = new Event();
            //ViewBag.EventEventId = currentEvent.EventId;
            //ViewBag.EventEventName = currentEvent.EventName;
            var comments = db.Comments.Include(c => c.Event);
            //var currentEvent = db.Comments.Include(c => c.Event);
            
            return View(comments.ToList());
        }

        // GET: Comments/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Comments comments = db.Comments.Find(id);
            if (comments == null)
            {
                return HttpNotFound();
            }
            return View(comments);
        }

        [HttpGet]
        // GET: Comments/Create
        public ActionResult Create(string id)
        {
            int eventId = int.Parse(id);

            Comments comments = new Comments();
            comments.EventEventId = eventId;
            ViewBag.EventEventName = db.Events.SingleOrDefault(x => x.EventId == eventId).EventName;
            //var currentEvent = new Event();
            //ViewBag.EventEventId = currentEvent.EventId;
            //ViewBag.EventEventName = currentEvent.EventName;

            //ViewData["EventId"] = db.Events.SingleOrDefault(x => x.EventId == eventId).EventId;
            return View(comments);
        }

        // POST: Comments/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Create([Bind(Include = "CId,CDescription,CDateTime,EventEventId")] Comments comments)
        {
            if (ModelState.IsValid)
            {
                //db.Comments.Add(comments);
                //db.SaveChanges();
                //return RedirectToAction("Index");
                System.Text.RegularExpressions.Regex rx = new System.Text.RegularExpressions.Regex("<[^>]*>");


                var newComment = db.Comments.Create();
                newComment.CDateTime = DateTime.Now.ToLocalTime();
                newComment.CDescription = rx.Replace(comments.CDescription, "");   //comments.CDescription.ToString();
                newComment.EventEventId = comments.EventEventId;
                db.Comments.Add(newComment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.EventEventId = new SelectList(db.Events, "EventId", "EventName", comments.EventEventId);
            return View(comments);
        }

        // GET: Comments/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Comments comments = db.Comments.Find(id);
            if (comments == null)
            {
                return HttpNotFound();
            }
            ViewBag.EventEventId = new SelectList(db.Events, "EventId", "EventName", comments.EventEventId);
            return View(comments);
        }

        // POST: Comments/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CId,CDescription,CDateTime,EventEventId")] Comments comments)
        {
            if (ModelState.IsValid)
            {
                db.Entry(comments).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.EventEventId = new SelectList(db.Events, "EventId", "EventName", comments.EventEventId);
            return View(comments);
        }

        // GET: Comments/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Comments comments = db.Comments.Find(id);
            if (comments == null)
            {
                return HttpNotFound();
            }
            return View(comments);
        }

        // POST: Comments/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Comments comments = db.Comments.Find(id);
            db.Comments.Remove(comments);
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

        //private static string HtmlToPlainText(string html)
        //{
        //    const string tagWhiteSpace = @"(>|$)(\W|\n|\r)+<";//matches one or more (white space or line breaks) between '>' and '<'
        //    const string stripFormatting = @"<[^>]*(>|$)";//match any character between '<' and '>', even when end tag is missing
        //    const string lineBreak = @"<(br|BR)\s{0,1}\/{0,1}>";//matches: <br>,<br/>,<br />,<BR>,<BR/>,<BR />
        //    var lineBreakRegex = new Regex(lineBreak, RegexOptions.Multiline);
        //    var stripFormattingRegex = new Regex(stripFormatting, RegexOptions.Multiline);
        //    var tagWhiteSpaceRegex = new Regex(tagWhiteSpace, RegexOptions.Multiline);

        //    var text = html;
        //    //Decode html specific characters
        //    text = System.Net.WebUtility.HtmlDecode(text);
        //    //Remove tag whitespace/line breaks
        //    text = tagWhiteSpaceRegex.Replace(text, "><");
        //    //Replace <br /> with line breaks
        //    text = lineBreakRegex.Replace(text, Environment.NewLine);
        //    //Strip formatting
        //    text = stripFormattingRegex.Replace(text, string.Empty);

        //    return text;
        //}
    }
}
