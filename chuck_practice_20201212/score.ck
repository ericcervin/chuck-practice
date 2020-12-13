//chuck_practice_20201212
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int kickID; int plsID; int snareID; int spID;//variables to hold program IDs

140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure

Machine.add(me.dir() + "/kick_09.ck") => kickID;
Machine.add(me.dir() + "/pulse.ck") => plsID;
Machine.add(me.dir() + "/snap_and_clap_09.ck") => snareID;
Machine.add(me.dir() + "/speaker.ck") => spID;

repeat(30){//30 wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    }

 //remove programs at end
 Machine.remove(kickID);
 Machine.remove(plsID);
 Machine.remove(snareID);
 Machine.remove(spID);

 



    
    



    