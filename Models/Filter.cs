using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
namespace PE2023test.Models
{
    public class Filter
    {
        Models.AuthorDataAccessLayer objauthor = new Models.AuthorDataAccessLayer();
        Models.BookDataAccessLayer objbook = new Models.BookDataAccessLayer();
        Models.Book_AuthorDataAccessLayer objbauthor = new Models.Book_AuthorDataAccessLayer();
        Models.CategoryDataAccessLayer objcategory = new Models.CategoryDataAccessLayer();
        Models.ReviewDataAccessLayer objreview = new Models.ReviewDataAccessLayer();

        public List<Author>? Authors{ get; set; }  = null!;
        public List<Category>? Category { get; set; } = null;
        public List<int>? Publication { get; set; } = null;
        public void Initiate()
        {
            this.Authors = objauthor.GetAllAuthors().ToList();
            this.Category = objcategory.GetAllCategories().ToList();
            this.Publication = objbook.GetAllPublicationYears().Distinct().ToList();
        }

    }
}
