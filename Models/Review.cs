using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
namespace PE2023test.Models
{
    public class Review
    {
        public int ISSNum { get; set; }=0;
        public int IDBook { get; set; }=0;
        public DateTime Review_date { get; set; } = DateTime.Now;
        public string Review_context { get; set; } = string.Empty;
        public int Review_star { get; set; } = 0;

        public void set(int id,int id_book) 
        { 
            this.IDBook = id_book;
            this.ISSNum = id;
        }
    }
}
