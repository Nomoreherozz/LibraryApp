using Microsoft.AspNetCore.Mvc;
using PE2023test.Models;
using System.Diagnostics;
using System.Web;
using Microsoft.AspNetCore.Http;

namespace PE2023test.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        Models.Auto_update_sys auto_Update_Sys = new Models.Auto_update_sys();
        Models.AuthorDataAccessLayer objauthor = new Models.AuthorDataAccessLayer();
        Models.BookDataAccessLayer objbook = new Models.BookDataAccessLayer();
        Models.Book_AuthorDataAccessLayer objbauthor = new Models.Book_AuthorDataAccessLayer();
        Models.CategoryDataAccessLayer objcategory = new Models.CategoryDataAccessLayer();
        Models.LeaseDataAccessLayer objlease = new Models.LeaseDataAccessLayer();
        Models.PaymentDataAccessLayer objpayment = new Models.PaymentDataAccessLayer();
        Models.UserDataAccessLayer objuser = new Models.UserDataAccessLayer();
        Models.FineDataAccessLayer objfine = new Models.FineDataAccessLayer();
        Models.ReviewDataAccessLayer objreview = new Models.ReviewDataAccessLayer();

        //public HomeController(ILogger<HomeController> logger)
        //{
        //   _logger = logger;
        //}
        public bool isValid() // check is valid user
        {
            bool isValid = false;
            int id = HttpContext.Session.GetInt32("ISSN").GetValueOrDefault();
            foreach (var item in objuser.GetAllUsers())
            {
                if (item.ISSN.Equals(id))
                {
                    isValid = true;
                }
            }
            return isValid;
        }

        public bool isAdmin()
        {
            auto_Update_Sys.run();
            int? id = HttpContext.Session.GetInt32("ISSN");
            Models.User user = objuser.GetUserData(id);
            if (user.ACCESS_CONTROL == 2)
            {
                return true;
            }
            else
            {
                return false;
            }
        }

        [HttpPost]
        public IActionResult Searchtest(String search) 
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                } else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }

            List<Models.Book> lstBook = new List<Models.Book>();
            lstBook = objbook.GetAllBooks().ToList();

            List<Models.ViewBook> lstViewBook = new List<Models.ViewBook>();
            if (!String.IsNullOrEmpty(search))
            {
                foreach (var book in lstBook)
                {
                    if (book.Title.Contains(search, StringComparison.OrdinalIgnoreCase))
                    {
                        Models.ViewBook bookView = new Models.ViewBook();
                        bookView.Initiate(book);
                        lstViewBook.Add(bookView);
                    }
                }
            }

            return View(lstViewBook);
        }

        public IActionResult Filter()
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }
            ViewBook viewBook = new ViewBook();
            Filter filter = new Filter();
            filter = viewBook.show_Filter();
            return View(filter);
        }

        [HttpPost]
        public IActionResult Search(string s1, string s2, string s3)
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }
            Console.WriteLine("1");
            Console.WriteLine(s1);
            Console.WriteLine(s2);
            Console.WriteLine(s3);

            List<ViewBook> lstvBook = new List<ViewBook>();
            Models.ViewBook viewBook = new Models.ViewBook();
            lstvBook = viewBook.res_Filter(s1, s2, s3).ToList();

            return View(lstvBook);
        }

        //Author
        public IActionResult AuthorIndex() 
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }
            List<Models.Author> lstAuthor = new List<Models.Author>();
            lstAuthor = objauthor.GetAllAuthors().ToList();

            return View(lstAuthor);
        }


        //Book
        public IActionResult BookIndex() //User
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }
            List<Models.Book> lstBook = new List<Models.Book>();
            lstBook = objbook.GetAllBooks().ToList();

            List<Models.ViewBook> lstViewBook = new List<Models.ViewBook>();
            foreach(var book in lstBook)
            {
                Models.ViewBook bookView = new Models.ViewBook();
                bookView.Initiate(book);
                lstViewBook.Add(bookView);
            }
            var list = lstViewBook.OrderByDescending(b => b.Book.ID).ToList();

            return View(lstViewBook);
        }

        [HttpGet]
        public IActionResult BookDetails(int? id) //User
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }
            if (id == null)
            {
                return NotFound();
            }
            Models.Book book = objbook.GetBookData(id);
            if (book == null)
            {
                return NotFound();
            }
            ViewBook viewBook = new ViewBook();
            viewBook.Initiate(book);

            return View(viewBook);
        }

        //GET: Register

        public ActionResult Register()
        {
            HttpContext.Session.Clear();
            return View();
        }

        //POST: Register
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(User _user)
        {
            if (ModelState.IsValid)
            {
                List<User> lstuser = objuser.GetAllUsers().ToList();
                bool check = true;
                foreach (var user in lstuser)
                {
                    if (user.ISSN == _user.ISSN) { check = false; break; }
                }

                if (check)
                {
                    //_user.hashPass();
                    objuser.AddUser(_user);

                    //add session
                    HttpContext.Session.Clear();
                    HttpContext.Session.SetInt32("ISSN", _user.ISSN);

                    //test
                    int? id = HttpContext.Session.GetInt32("ISSN");
                    ViewBag.Message = "ID: " + id;

                    return RedirectToAction("BookIndex"); //"User",_user
                }
                else
                {
                    ViewBag.Message = "Login Failed";
                    return RedirectToAction("Register");
                }
            }
            else { return NotFound(); }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(string ISSN, string password)
        {
            if (ModelState.IsValid)
            {
                
                User user = objuser.GetUserData(Int32.Parse(ISSN));
                if (user.Pass.Equals(password) && user != null)
                {
                    //add session
                    HttpContext.Session.Clear();
                    HttpContext.Session.SetInt32("ISSN", user.ISSN);

                    //test
                    int? id = HttpContext.Session.GetInt32("ISSN");
                    ViewBag.ISSN = id;
                    if (this.isAdmin())
                    {
                        ViewBag.Layout = "_Layout1";
                    }
                    else { ViewBag.Layout = "_Layout1_cus"; }
                    ViewBag.Message = "ID : " + id;
                    //return RedirectToAction("BookIndex");//"User",_user
                }
                else
                {
                    ViewBag.Layout = "_Layout";
                    ViewBag.Message = "Login failed";
                    //return RedirectToAction("BookIndex");//"Login"
                }
            }

            ViewBook viewBook = new ViewBook();
            List<Models.ViewBook> lstViewBook = new List<Models.ViewBook>();
            lstViewBook = viewBook.show_all_books().ToList();
            
            auto_Update_Sys.run();
            return View(lstViewBook);
        }

        
        public RedirectToActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("BookIndex");
        }

        [HttpGet]
        public IActionResult UserDetails() //User
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }
            int? id = HttpContext.Session.GetInt32("ISSN");
            Models.User user = objuser.GetUserData(id);

            if (user == null)
            {
                return NotFound();
            }
            return View(user);
        }

        [HttpGet]
        public IActionResult UserEdit() //User
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }
            int? id = HttpContext.Session.GetInt32("ISSN");
            if (!this.isValid())
            {
                return NotFound();
            }
            Models.User user = objuser.GetUserData(id);

            if (user == null)
            {
                return NotFound();
            }
            return View(user);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult UserEdit([Bind] Models.User user) //User
        {
            int? id = HttpContext.Session.GetInt32("ISSN").GetValueOrDefault();
            if (!this.isValid())
            {
                return NotFound();
            }
            if (ModelState.IsValid)
            {
                objuser.UpdateUser(user);
                return RedirectToAction("UserDetails");
            }
            return View();
        }

        public IActionResult LeaseIndex()
        {
            if (!this.isValid())
            {
                return NotFound();
            }
            else
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            int id = HttpContext.Session.GetInt32("ISSN").GetValueOrDefault();
            Lease lease = new Lease();
            List<Lease> leases = new List<Lease>();

            leases = lease.Take_lease_for_ISSN_acti(id).ToList();
            return View(leases);
        }

        [HttpGet]
        public IActionResult LeaseCreate(int book_ID)
        {
            if (!this.isValid())
            {
                return RedirectToAction("Register");
            }
            else
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            
            HttpContext.Session.SetInt32("Book_ID", book_ID);
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult LeaseCreate([Bind] Models.Lease lease)
        {
            if (!this.isValid())
            {
                return NotFound();
            }

            int? id = HttpContext.Session.GetInt32("ISSN");
            int? id2 = HttpContext.Session.GetInt32("Book_ID");
            int bid = HttpContext.Session.GetInt32("Book_ID").GetValueOrDefault();
            var interval_date_to_lease = new TimeSpan(7, 0, 0, 0);

            lease.SessionID = objlease.Take_new_SessionID();
            lease.getISSN(id);
            lease.getBook_ID(id2);
            if (lease.Expiry_date < lease.Lease_date.Add(interval_date_to_lease))
            {
                lease.Expiry_date = lease.Lease_date.Add(interval_date_to_lease);
            }

            if (!lease.is_available_to_create())
            {
                return RedirectToAction("Error_to_lease_book");
            }
            else if (lease.isValid())
            {
                objlease.AddLease(lease);
                return RedirectToAction("LeaseDetails", new { id = lease.SessionID });//page book? or lease details
            }
            auto_Update_Sys.run();

            return View(lease);
        }

        [HttpGet]
        public IActionResult LeaseDetails(int? id) //User
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }

            if (id == null)
            {
                return NotFound();
            }
            Models.Lease lease = objlease.GetLeaseData(id);
            lease.get_name_book();

            if (lease == null)
            {
                return NotFound();
            }
            return View(lease);
        }
        [HttpGet]
        public IActionResult PaymentCreate(int id_lease)
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }

            Payment pay = new Payment();
            int id = HttpContext.Session.GetInt32("ISSN").GetValueOrDefault();
            

            if (pay.check_paid(id_lease))
            {
                return NotFound();
            }
            
            pay.create_Payment_form(id_lease, id);
            

            return View(pay);
        }

        [HttpPost, ActionName("PaymentCreate")]
        public IActionResult ProcessPaymentCreate(int id_lease)
        {
            Payment pay = new Payment();
            int id = HttpContext.Session.GetInt32("ISSN").GetValueOrDefault();
            pay.create_Payment_form(id_lease, id);
            objpayment.AddPayment(pay);
            auto_Update_Sys.run();
            return RedirectToAction("LeaseDetails", new {id=pay.Payment_ID});

        }

        [HttpGet]
        public IActionResult ReviewCreate(int id) //USER
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }

            HttpContext.Session.SetInt32("Book_ID", id);
            if (!this.isValid())
            {
                return NotFound();
            }
            return View();
        }

        [HttpPost]
        public IActionResult ReviewCreate([Bind] Models.Review review) //USER
        {
            int id = HttpContext.Session.GetInt32("ISSN").GetValueOrDefault();
            int id_book = HttpContext.Session.GetInt32("Book_ID").GetValueOrDefault();
            review.set(id, id_book);
            if (ModelState.IsValid)
            {
                objreview.AddReview(review);
                return RedirectToAction("BookDetails", new { id = review.IDBook });
            }
            return View(review);
        }
        

        [HttpGet]
        public ActionResult SetViewBag(string? s1,string? s2, string? s3)
        {
            Console.WriteLine("1");
            Console.WriteLine(s1);
            Console.WriteLine(s2);
            Console.WriteLine(s3);
            //Console.WriteLine(s4);

            List<ViewBook> lstvBook = new List<ViewBook>();
            Models.ViewBook viewBook = new Models.ViewBook();
            lstvBook = viewBook.res_Filter(s1, s2, s3).ToList();

            return PartialView("Searchtest",lstvBook);
            
        }

        [HttpGet]
        public ActionResult LogoTeam()
        {
            if (this.isValid())
            {
                if (this.isAdmin())
                {
                    ViewBag.Layout = "_Layout1";
                }
                else { ViewBag.Layout = "_Layout1_cus"; }
            }
            else { ViewBag.Layout = "_Layout"; }

            return View();
        }
    }
}