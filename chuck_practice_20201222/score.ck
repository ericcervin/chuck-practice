//chuck_practice_20201222
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int gcID;//variables to hold program IDs

140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure

Machine.add(me.dir() + "/grain_cloud.ck") => gcID;

repeat(35){//35 wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    
    if (counter.Measure == 34){
        Machine.remove(gcID);}
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    }