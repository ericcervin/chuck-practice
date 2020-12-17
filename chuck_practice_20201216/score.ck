//chuck_practice_20201216
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int kickID; int tomsID;int gcID;//variables to hold program IDs

140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure

Machine.add(me.dir() + "/toms_09.ck") => tomsID;
Machine.add(me.dir() + "/kick_09.ck") => kickID;
Machine.add(me.dir() + "/grain_chain.ck") => gcID;


repeat(34){//34 wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    if (counter.Measure == 33){Machine.remove(kickID);Machine.remove(tomsID);}
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    }

 Machine.remove(gcID);

 



    
    



    