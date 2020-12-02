//chuck_practice_20201201
//TheCount.ck

public class TheCount{
//simplest possible class. created so multiple shreds can keep track of where they are in a piece.
//may upgrade later to count movements, sections, etc.
    
    //global member variable
    static int Measure; //measure like on a piece of sheet music. length depends on time signature
    
    fun void setMeasure(int mess){//method to arbitrarily set the current measure #
        mess => Measure;
        }
        
    fun void AddMeasure(){//method to increment the current measure number. 
        1 +=> Measure;
        }
    
}