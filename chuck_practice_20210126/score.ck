//chuck_practice_20210126
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int kickID; int ssID;
140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure


Machine.add(me.dir() + "/sample_slicer.ck") => ssID;
repeat(34){//wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    if (counter.Measure == 13){
        Machine.add(me.dir() + "/kick_09.ck") => kickID;
    }
    if (counter.Measure == 34){
        Machine.remove(kickID);
        Machine.remove(ssID);
    }
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    }
