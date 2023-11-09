using System;
using System.Collections.Generic;
using System;
using System.Data;

using MySql.Data;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Net.Mail;
using System.Net;
namespace PE2023test.Models
{
    public class Auto_update_sys
    {
        string connectionString = "server=vgu.pe.2023.database;user=root;database=pe2023;port=3306;password=Kaka12345";

        Models.AuthorDataAccessLayer objauthor = new Models.AuthorDataAccessLayer();
        Models.BookDataAccessLayer objbook = new Models.BookDataAccessLayer();
        Models.Book_AuthorDataAccessLayer objbauthor = new Models.Book_AuthorDataAccessLayer();
        Models.CategoryDataAccessLayer objcategory = new Models.CategoryDataAccessLayer();
        Models.LeaseDataAccessLayer objlease = new Models.LeaseDataAccessLayer();
        Models.PaymentDataAccessLayer objpayment = new Models.PaymentDataAccessLayer();
        Models.UserDataAccessLayer objuser = new Models.UserDataAccessLayer();
        Models.FineDataAccessLayer objfine = new Models.FineDataAccessLayer();
        Models.ReviewDataAccessLayer objreview = new Models.ReviewDataAccessLayer();
        public void run(int i=0)
        {
            using (MySqlConnection con = new MySqlConnection(connectionString))
            {
                MySqlCommand cmd = new MySqlCommand("ISUDFine", con);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Session_ID", null);
                cmd.Parameters.AddWithValue("@Finedays", null);
                cmd.Parameters.AddWithValue("@Fineamount", null);
                cmd.Parameters.AddWithValue("@StatementType", "SELECT");
                con.Open();
                MySqlDataReader rdr = cmd.ExecuteReader();

                List<Models.Payment> lstPayment = new List<Models.Payment>();
                lstPayment = objpayment.GetAllPayments().ToList();

                while (rdr.Read())
                {
                    Fine fine = new Fine();
                    int sessID = Convert.ToInt32(rdr["SessionID"]);
                    Models.Lease lease1 = objlease.GetLeaseData(sessID);

                    //check inconsistent DB
                    foreach (var payment in lstPayment)
                    {
                        if (payment.Payment_ID == sessID && lease1.Status.Equals("active"))
                        {
                            lease1.Status = "de-active";
                            objlease.UpdateLease(lease1);
                        }
                    }

                    //update fine following lease still validating
                    if (lease1.Status.Equals("active"))
                    {
                        fine.ini(sessID, (DateTime.Now - lease1.Expiry_date).Days);
                        if (fine.Fine_amount < 0 || fine.Fine_days <0)
                        { 
                            fine.Fine_amount = 0;
                            fine.Fine_days = 0;
                        }

                        objfine.UpdateFine(fine); 
                    }


                    // automatically send email
                    int days = (DateTime.Now - lease1.Expiry_date).Days;
                    if (lease1.Notify() && i == 1)
                    {
                        var smtpClient = new SmtpClient("smtp.gmail.com")
                        {
                            Port = 587,
                            Credentials = new NetworkCredential("15001@student.vgu.edu.vn", "X7U~sjm?"),
                            EnableSsl = true,
                        };

                        smtpClient.Send("15001@student.vgu.edu.vn", objuser.GetUserData(lease1.ISSN).Email, "Expired lease", "this is " + days + " days after the expired_date: " + lease1.Expiry_date);
                    }


                }
                con.Close();
                //check automotically is it fine create for lease?
                List<Lease> leases = new List<Lease>();
                List<int> leases_id = new List<int>();
                leases = objlease.GetAllLeases().ToList();
                foreach (Lease lease in leases)
                {
                    leases_id.Add(lease.SessionID);
                }

                List<Fine> fines = new List<Fine>();
                List<int> fines_id = new List<int>();
                fines = objfine.GetAllFines().ToList();
                foreach(Fine fine in fines)
                {
                    fines_id.Add(fine.SessionID);
                }

                foreach (int l_id in leases_id)
                {
                    if (!fines_id.Contains(l_id))
                    {
                        Fine fine = new Fine();
                        fine.ini(l_id, (DateTime.Now - objlease.GetLeaseData(l_id).Expiry_date).Days);
                        if (fine.Fine_amount < 0 || fine.Fine_days < 0)
                        {
                            fine.Fine_amount = 0;
                            fine.Fine_days = 0;
                        }
                        objfine.AddFine(fine);
                    }
                }

            }
        }
    }
}


        