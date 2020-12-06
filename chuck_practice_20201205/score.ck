//chuck_practice_20201205
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int kickID; int spID;//variables to hold program IDs

140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure

Machine.add(me.dir() + "/speaker.ck") => spID;    //start program that will run throughout
Machine.add(me.dir() + "/kick.ck") => kickID;

repeat(30){//30 wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    }

 //remove programs at end
 Machine.remove(spID);
 Machine.remove(kickID);
 

 



    
    



    