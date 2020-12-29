//chuck_practice_20201228
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;



int gcID;//variables to hold program IDs

280 => float beat; // Beats per minute
tempo.tempo(beat); 
counter.setMeasure(1);//set counter to first measure



repeat(64){//wholenote(4 beat) measures
    <<<"measure ",counter.Measure>>>;
    repeat(4){
      Machine.add(me.dir() + "/grain_cloud.ck") => gcID;
      tempo.quarterNote=> now;
    }
    counter.AddMeasure();//increment measure count
    }