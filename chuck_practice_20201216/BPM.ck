//chuck_practice_20201216
//BPM.ck

public class BPM{

    //global member variables
    dur myDuration[6];
    static dur wholeNote, halfNote, quarterNote, eighthNote, sixteenthNote, thirtysecondNote;
    
    fun void tempo (float beat){
        //beat is BPM, for example 140 beats per minute
        60.0/(beat) => float SPB; //second per beat
        //<<<"seconds per beat = ",SPB>>>;
        SPB::second => quarterNote;
        quarterNote*4 => wholeNote;//duration I added to class from lecture
        quarterNote*2 => halfNote;//duration I added to class from lecture
        quarterNote*0.5 => eighthNote;
        eighthNote*0.5 => sixteenthNote;
        sixteenthNote*0.5 => thirtysecondNote;
        
        // store data in array
        [wholeNote, halfNote, quarterNote, eighthNote, sixteenthNote, thirtysecondNote] @=> myDuration;
        
        }
    
}