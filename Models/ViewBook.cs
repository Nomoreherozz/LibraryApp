using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
namespace PE2023test.Models
{
    public class ViewBook
    {
        Models.AuthorDataAccessLayer objauthor = new Models.AuthorDataAccessLayer();
        Models.BookDataAccessLayer objbook = new Models.BookDataAccessLayer();
        Models.Book_AuthorDataAccessLayer objbauthor = new Models.Book_AuthorDataAccessLayer();
        Models.CategoryDataAccessLayer objcategory = new Models.CategoryDataAccessLayer();
        Models.ReviewDataAccessLayer objreview = new Models.ReviewDataAccessLayer();
        Models.Take_add_img_Book taib = new Models.Take_add_img_Book();
        Models.Take_Description_Book tdb = new Models.Take_Description_Book();
        Models.Filter objfilter = new Models.Filter();
        Models.LeaseDataAccessLayer objlease = new Models.LeaseDataAccessLayer();

        public Book? Book { get; set; }
        public List<Author>? Authors{ get; set; }
        public Category? Category { get; set; } = null;
        public List<Review>? Review { get; set; } = null;
        public int avgStar = 0;
        public string add_img_Book = string.Empty;
        public string Description = string.Empty;
        public int available = 0;
        public void Initiate(Book book)
        {
            Book = book;
            Authors = new List<Author>();
            Category = new Category();

            List<Models.Book_Author> lstBAuthor = new List<Models.Book_Author>();
            lstBAuthor = objbauthor.GetBook_AuthorData(book.ID).ToList();
            foreach (Models.Book_Author bauthor in lstBAuthor)
            {
                this.Authors?.Add(objauthor.GetAuthorData(bauthor.AuthorID));
            }

            this.Category = objcategory.GetBook_CategoryData(book.ID);

            this.Review = objreview.GetReviewDataForBook(book.ID).ToList();

            int Star = 0;
            foreach(Models.Review review in Review)
            {
                Star += review.Review_star;
            }
            if(this.Review.Count > 0) { this.avgStar = Star / this.Review.Count; }
            else { this.avgStar = 0; }

            this.add_img_Book = taib.get_add(book.ID);

            this.Description = tdb.get_add(book.ID);

            this.available =this.Book.Quantity - objlease.Take_num_leases_for_Book(this.Book.ID);
        }
        public Filter show_Filter()
        {
            objfilter.Initiate();
            return objfilter;
        }
        public List<ViewBook> show_all_books()
        {
            List<Models.Book> lstBook = new List<Models.Book>();
            lstBook = objbook.GetAllBooks().ToList();

            List<Models.ViewBook> lstViewBook = new List<Models.ViewBook>();
            foreach (var book in lstBook)
            {
                Models.ViewBook bookView = new Models.ViewBook();
                bookView.Initiate(book);
                lstViewBook.Add(bookView);
            }
            return lstViewBook;
        }
        public List<ViewBook> res_Filter(string? category, string? author, string? publication)//SOLUTION 2
        {
            List<Models.ViewBook> lstViewBook = this.show_all_books();
            List<Models.ViewBook> lstViewBook_res = new List<Models.ViewBook>();
            List<Models.ViewBook> lstViewBook_cat = new List<Models.ViewBook>();
            List<Models.ViewBook> lstViewBook_aut = new List<Models.ViewBook>();
            List<Models.ViewBook> lstViewBook_pub = new List<Models.ViewBook>();
            //Models.FilterDataAccessLayer filterLayer = new Models.FilterDataAccessLayer();
            //lstViewBook = filterLayer.GetFilterBooks(category, author, publication).ToList();
            if (!String.IsNullOrEmpty(category))
            {
                foreach (var vbook in lstViewBook)
                {
                    if (vbook.Category.Category_name.Equals(category, StringComparison.OrdinalIgnoreCase))
                    {
                        lstViewBook_cat.Add(vbook);
                    }
                }
            }
            else { lstViewBook_cat = this.show_all_books().ToList(); }

            if (!String.IsNullOrEmpty(author))
            {
                List<Models.Book_Author> lstBAuthor = new List<Models.Book_Author>();
                lstBAuthor = objbauthor.GetAllBook_Authors().ToList();

                foreach (var bauthor in lstBAuthor)
                {
                    if (objauthor.GetAuthorData(bauthor.AuthorID).Author_fname.Equals(author, StringComparison.OrdinalIgnoreCase))
                    {
                        Models.ViewBook bookView = new Models.ViewBook();
                        bookView.Initiate(objbook.GetBookData(bauthor.BookID));
                        lstViewBook_aut.Add(bookView);
                    }
                }
            }
            else { lstViewBook_aut = this.show_all_books().ToList(); }

            if (!String.IsNullOrEmpty(publication))
            {
                foreach (var vbook in lstViewBook)
                {
                    if (vbook.Book.Publication_Year.ToString().Equals(publication))
                    {
                        lstViewBook_pub.Add(vbook);
                    }
                }
            }
            else { lstViewBook_pub = this.show_all_books().ToList(); }

            foreach (ViewBook cat in lstViewBook_cat)
            {
                foreach(ViewBook aut in lstViewBook_aut)
                {
                    if(aut.Book.ID == cat.Book.ID)
                    {
                        lstViewBook_res.Add(cat);
                    }
                }
                
            }

            List<ViewBook> lstViews = new List<ViewBook>();
            foreach (ViewBook pub in lstViewBook_pub)
            {
                foreach (ViewBook res in lstViewBook_res)
                {
                    if (pub.Book.ID == res.Book.ID)
                    {
                        lstViews.Add(res);
                    }
                }

            }
            return lstViews;
        }
    }
}
