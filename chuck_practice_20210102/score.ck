//chuck_practice_20210102
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;



int ddID; int bdID;//variables to hold program IDs

140 => float beat; // Beats per minute
tempo.tempo(beat); 
counter.setMeasure(1);//set counter to first measure

Machine.add(me.dir() + "/different_drummer.ck") => ddID;
Machine.add(me.dir() + "/kick_09.ck") => bdID;

repeat(36){//wholenote(4 beat) measures
    <<<"measure ",counter.Measure>>>;
    if (counter.Measure == 35){
        Machine.remove(ddID);
        Machine.remove(bdID);
        }
    tempo.wholeNote => now;    
    counter.AddMeasure();//increment measure count
    }
     