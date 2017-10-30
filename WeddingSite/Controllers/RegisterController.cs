using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WeddingSite.Models;
using System.Net;
using System.Net.Mail;

namespace WeddingSite.Controllers
{
    public class RegisterController : Controller
    {
        // GET: Register
        public ActionResult Index()
        {
            return View();
        }
        
        [HttpPost]
        public ActionResult Index(Register obj, FormCollection form)
        {
            //if (ModelState.IsValid)
            //{
                ChicadressEntities db = new ChicadressEntities();
                var radio = Convert.ToString(form["credit-card"].ToString());
                if(radio == "Bride")
                {
                    obj.Bride = Convert.ToBoolean(1);
                    obj.Groom = Convert.ToBoolean(0);
                }
                else if (radio == "Groom")
                {
                    obj.Groom = Convert.ToBoolean(1);
                    obj.Bride = Convert.ToBoolean(0);
                }
                db.Registers.Add(obj);
                db.SaveChanges();

            string message = string.Empty;
            switch (obj.Id)
            {
                case -1:
                    message = "Username already exists.\\nPlease choose a different username.";
                    break;
                case -2:
                    message = "Supplied email address has already been used.";
                    break;
                default:
                    message = "Registration successful.\\nUser Id: " + obj.Id.ToString();
                    SendActivationEmail(obj);
                    break;
            }
            ViewBag.Message = message;
            //}
            return RedirectToAction("Login");
        }

        

        
        public ActionResult Activation()
        {
            ViewBag.Message = "Invalid Activation code.";
            if (RouteData.Values["id"] != null)
            {
                Guid activationCode = new Guid(RouteData.Values["id"].ToString());
                ChicadressEntities usersEntities = new ChicadressEntities();
                UserActivation userActivation = usersEntities.UserActivations.Where(p => p.AcitivationCode == activationCode).FirstOrDefault();
                if (userActivation != null)
                {
                    usersEntities.UserActivations.Remove(userActivation);
                    usersEntities.SaveChanges();
                    ViewBag.Message = "Activation successful.";
                }
            }

            return View();
        }

        private void SendActivationEmail(Register user)
        {
            Guid activationCode = Guid.NewGuid();
            ChicadressEntities usersEntities = new ChicadressEntities();
            usersEntities.UserActivations.Add(new UserActivation
            {
                UserId = user.Id,
                AcitivationCode = activationCode
            });
            usersEntities.SaveChanges();

            using (MailMessage mm = new MailMessage("latikasood.in@gmail.com", user.Email))
            {
                mm.Subject = "Account Activation";
                string body = "Hello " + user.Name + ",";
                body += "<br /><br />Please click the following link to activate your account";
                body += "<br /><a href = '" + string.Format("{0}://{1}/Register/Activation/{2}", Request.Url.Scheme, Request.Url.Authority, activationCode) + "'>Click here to activate your account.</a>";
                body += "<br /><br />Thanks";
                mm.Body = body;
                mm.IsBodyHtml = true;
                SmtpClient smtp = new SmtpClient();
                smtp.Host = "smtp.gmail.com";
                smtp.EnableSsl = true;
                NetworkCredential NetworkCred = new NetworkCredential("latikasood.in@gmail.com", "akital1991");
                smtp.UseDefaultCredentials = true;
                smtp.Credentials = NetworkCred;
                smtp.Port = 587;
                smtp.Send(mm);
            }
        }

        public ActionResult Information()
        {
            return View();
        }

        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(Register objUser)
        {
            if (ModelState.IsValid)
            {
                using (ChicadressEntities db = new ChicadressEntities())
                {
                    var obj = db.Registers.Where(a => a.Email.Equals(objUser.Email) && a.Password.Equals(objUser.Password)).FirstOrDefault();
                    if (obj != null)
                    {
                        Session["Id"] = obj.Id.ToString();
                        Session["Email"] = obj.Email.ToString();
                        return RedirectToAction("Index", "Dashboard", obj);
                    }
                }
            }
            return View(objUser);
        }

        public String Contact()
        {            
            return "Success";
        }
    }
}