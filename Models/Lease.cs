using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
namespace PE2023test.Models
{
    public class Lease
    {
        Models.AuthorDataAccessLayer objauthor = new Models.AuthorDataAccessLayer();
        Models.BookDataAccessLayer objbook = new Models.BookDataAccessLayer();
        Models.Book_AuthorDataAccessLayer objbauthor = new Models.Book_AuthorDataAccessLayer();
        Models.CategoryDataAccessLayer objcategory = new Models.CategoryDataAccessLayer();
        Models.LeaseDataAccessLayer objlease = new Models.LeaseDataAccessLayer();
        Models.PaymentDataAccessLayer objpayment = new Models.PaymentDataAccessLayer();
        Models.UserDataAccessLayer objuser = new Models.UserDataAccessLayer();
        Models.FineDataAccessLayer objfine = new Models.FineDataAccessLayer();
        Models.ReviewDataAccessLayer objreview = new Models.ReviewDataAccessLayer();

        public int SessionID { get; set; }
        public int Book_ID { get; set; }
        public int ISSN { get; set; }
        public DateTime Lease_date { get; set; }
        public DateTime Expiry_date { get; set; }
        public string Status { get; set; } = "active";
        public string Name_Book { get; set; } = string.Empty; 

        public void getISSN(int? id)
        {
            this.ISSN = id.GetValueOrDefault();
        }
        public void getBook_ID(int? id)
        {
            this.Book_ID = id.GetValueOrDefault();
        }

        public bool Notify()
        {
            if (this.Expiry_date < DateTime.Now && this.Status.Equals("active",StringComparison.OrdinalIgnoreCase))
            {
                return true;
            }
            else { return false;}
        } 

        public bool isValid()
        {
            try
            {
                if (SessionID.Equals(null) || Book_ID.Equals(null) || ISSN.Equals(null) || Lease_date.Equals(null) || Expiry_date.Equals(null))
                {
                    return false;
                }
                else { return true; };
            }
            catch (Exception e)
            {
                throw new Exception(e.ToString());
            }
        }

        public bool is_available_to_create()
        {
            bool res = false;
            bool consist = false;
            List<Lease> leases = new List<Lease>();
            leases = objlease.GetAllLeases().ToList();
            int able_to_borrow = objbook.GetBookData(this.Book_ID).Quantity;

            if(leases.Count(n=>n.Book_ID.Equals(this.Book_ID)) < able_to_borrow)
            {
                res = true;
            }

            foreach(Lease lease in leases)
            {
                if (lease.Book_ID.Equals(this.Book_ID) && lease.ISSN.Equals(this.ISSN))
                {
                    consist = true;
                    break;
                }
            }

            return res && !consist;
        }
        public List<Lease> Take_lease_for_ISSN_acti(int id_user)
        {
            List<Models.Lease> lstlease = new List<Models.Lease>();
            List<Models.Lease> lstres = new List<Models.Lease>();
            lstlease = objlease.GetAllLeases().ToList();

            foreach(Models.Lease lease in lstlease)
            {
                if(lease.ISSN.Equals(id_user) && lease.Status.Equals("active",StringComparison.OrdinalIgnoreCase))
                {
                    lease.get_name_book();
                    lstres.Add(lease);
                }
            }

            return lstres;
        }
        public List<Lease> Take_lease_for_ISSN(int id_user)
        {
            List<Models.Lease> lstlease = new List<Models.Lease>();
            List<Models.Lease> lstres = new List<Models.Lease>();
            lstlease = objlease.GetAllLeases().ToList();

            foreach (Models.Lease lease in lstlease)
            {
                if (lease.ISSN.Equals(id_user))
                {
                    lease.get_name_book();
                    lstres.Add(lease);
                }
            }

            return lstres;
        }

        public List<Lease> Take_lease_for_Book(int id_book)
        {
            List<Models.Lease> lstlease = new List<Models.Lease>();
            List<Models.Lease> lstres = new List<Models.Lease>();
            lstlease = objlease.GetAllLeases().ToList();

            foreach (Models.Lease lease in lstlease)
            {
                if (lease.Book_ID.Equals(id_book) && lease.Status.Equals("active",StringComparison.OrdinalIgnoreCase))
                {
                    lease.get_name_book();
                    lstres.Add(lease);
                }
            }

            return lstres;
        }

        public void get_name_book()
        {
            this.Name_Book = objbook.GetBookData(Book_ID).Title.ToString();
        }
    }
}
