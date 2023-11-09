using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
namespace PE2023test.Models
{
    public class Payment
    {
        Models.LeaseDataAccessLayer objlease = new Models.LeaseDataAccessLayer();
        public int Payment_ID { get; set; }
        [Required]
        public int Customer_ID { get; set; }
        public DateTime Lease_date { get; set; } = DateTime.Now;
        public DateTime Payment_date { get; set; } = DateTime.Now;
        public int Payment_amount { get; set; } = 7000;
        public void get_auto_amount_for_lease(int id_lease)
        {
            
            Models.FineDataAccessLayer objfine = new Models.FineDataAccessLayer();
            Lease lease = objlease.GetLeaseData(id_lease);

            this.Payment_amount = (lease.Expiry_date - lease.Lease_date).Days * 1000 + objfine.GetFineData(id_lease).Fine_amount;
        }
        public void create_Payment_form(int pay_id, int ISSN)
        {
            this.Payment_ID = pay_id;
            this.Customer_ID = ISSN;
            this.Lease_date = objlease.GetLeaseData(pay_id).Lease_date;
            get_auto_amount_for_lease(pay_id);
        }
        public bool check_paid(int pay_id)
        {
            bool res = false;
            Models.PaymentDataAccessLayer objpayment = new Models.PaymentDataAccessLayer();
            List<Payment> payments = new List<Payment>();
            payments = objpayment.GetAllPayments().ToList();
            foreach (Payment pay in payments)
            {
                if (pay.Payment_ID == pay_id)
                {
                    res = true;
                }
            }

            return res;
        }
    }
}
