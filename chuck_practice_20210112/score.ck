//chuck_practice_20210112
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int kickID; int ssID; int rtID; int scID; int pID;

140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure

Machine.add(me.dir() + "/kick_09.ck") => kickID;
Machine.add(me.dir() + "/sample_slicer.ck") => ssID;
Machine.add(me.dir() + "/reich_thing_1965.ck") => rtID;
Machine.add(me.dir() + "/snap_and_clap_09.ck") => scID;
Machine.add(me.dir() + "/pulse.ck") => pID;

repeat(17){//wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    
    if (counter.Measure == 17){
        Machine.remove(kickID);
        Machine.remove(ssID);
        Machine.remove(rtID);
        Machine.remove(scID);
        Machine.remove(pID);}
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    }