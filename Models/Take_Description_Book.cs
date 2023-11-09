using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
namespace PE2023test.Models
{
    public class Take_Description_Book
    {
        public string script = string.Empty;
        private string[,] data = new string[,]
        { 
            {"1","The Da Vinci Code follows symbologist Robert Langdon and cryptologist Sophie Neveu after a murder in the Louvre Museum in Paris causes them to become involved in a battle between the Priory of Sion and Opus Dei over the possibility of Jesus Christ and Mary Magdalene having had a child together." },
            {"2","The Horus Heresy: Book Five - Tempest is the fifth book released as part of Forge World's Horus Heresy Series of campaign and army books that takes place during the Horus Heresy. The book deals with the Calth Atrocity, where the Word Bearers Legion launched a devestating suprise attack on the Ultramarines Legion."},
            {"3","The story is set in motion by a family hiking trip, during which Trisha's brother, Pete, and mother constantly squabble about the mother's divorce from their father, as well as other topics."},
            {"4","Warframe hay lắm, thử chơi tí đi bạn ko nghiện đâu yên tâm"},
            {"5","Set in the world of Cyberpunk 2077, one of the bestselling video games of recent years, from acclaimed Polish science fiction writer Rafał Kosik, this electrifying novel follows a group of strangers as they discover that the dangers of Night City are all too real."},
            {"6","Triss là của tôi còn Yennefer thì để Geralt nhá"},
            {"7","Benedict Cumberbatch đóng Sherlock đỉnh của chóp"},
            {"8","The Return of the King is the third and final volume of J. R. R. Tolkien's The Lord of the Rings, following The Fellowship of the Ring and The Two Towers."},
            {"9","Hội Phượng Hoàng nhưng chết gần hêt cả hội, hội CHmúA Hmề thì có"},
        };

        public string get_add(int id)
        {
            for (int i = 0; i < data.GetLength(0); i++)
            {
                if (Convert.ToInt32(this.data[i, 0]) == id)
                {
                    this.script = this.data[i, 1];
                }
            }
            return this.script;
        }
    }
}


