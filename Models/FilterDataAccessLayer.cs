using System;
using System.Collections.Generic;
using System;
using System.Data;

using MySql.Data;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Threading.Tasks;
namespace PE2023test.Models
{
    public class FilterDataAccessLayer
    {
        string connectionString = "server=vgu.pe.2023.database;user=root;database=pe2023;port=3306;password=Kaka12345";

        public IEnumerable<ViewBook> GetFilterBooks(string category, string author, int publication) //view all book follow filters SOLUTION1
        {
            List<Models.ViewBook> lstViewBook = new List<Models.ViewBook>();
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                string check_cate = String.Empty;
                string check_aut = String.Empty;
                string check_pub = String.Empty;
                string conn_aut = String.Empty;
                string conn_pub = String.Empty;

                if (!String.IsNullOrEmpty(category))
                {
                    check_cate = " category.Category_name = " + category;
                }
                if (!String.IsNullOrEmpty(author))
                {
                    check_aut = " author.Author_fname = " + author;
                }
                if(!String.IsNullOrEmpty(publication.ToString()))
                {
                    check_pub = " book.Publication_year = " + publication.ToString();
                }

                if(!String.IsNullOrEmpty(check_cate) && !String.IsNullOrEmpty(check_aut))
                {
                    conn_aut = " AND";
                }
                if ((!String.IsNullOrEmpty(check_cate) || !String.IsNullOrEmpty(check_aut)) && !String.IsNullOrEmpty(check_pub))
                {
                    conn_pub = " AND";
                }


                string sqlQuery = "SELECT DISTINCT book.Book_ID FROM category JOIN book JOIN author JOIN book_author" 
                                + " WHERE"+ check_cate + conn_aut + check_aut + conn_pub + check_pub;
                MySqlCommand cmd = new MySqlCommand(sqlQuery, con);

                con.Open();
                MySqlDataReader rdr = cmd.ExecuteReader();

                List<Models.Book> lstBook = new List<Models.Book>();
                Models.BookDataAccessLayer objbook = new Models.BookDataAccessLayer();
                
                
                while (rdr.Read())
                {
                    int id = Convert.ToInt32(rdr["Book_ID"]);
                    Models.ViewBook bookView = new Models.ViewBook();
                    bookView.Initiate(objbook.GetBookData(id));
                    lstViewBook.Add(bookView);
                }

                con.Close();
            }
            return lstViewBook;
        }

    }
}


        