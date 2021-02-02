//chuck_practice_20210201
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int kickID; int ssID; int plsID; int tmsID;
140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure


Machine.add(me.dir() + "/sample_slicer.ck") => ssID;
repeat(30){//wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    
    if (counter.Measure == 13){
        Machine.add(me.dir() + "/pulse.ck") => plsID;
        Machine.add(me.dir() + "/kick_09.ck") => kickID;
        Machine.add(me.dir() + "/toms_09.ck") => tmsID;
    }
    if (counter.Measure == 29){
        Machine.remove(tmsID);
    }
    if (counter.Measure == 30){
        Machine.remove(kickID);
        Machine.remove(ssID);
        Machine.remove(plsID);
        
    }
    
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
}
