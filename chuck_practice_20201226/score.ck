//chuck_practice_20201226
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;



int gcID;//variables to hold program IDs

140 => float beat; // Beats per minute
tempo.tempo(beat); 
counter.setMeasure(1);//set counter to first measure



repeat(48){//48 wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    repeat(4){
      Machine.add(me.dir() + "/grain_cloud.ck") => gcID;
      tempo.quarterNote=> now;
    }
    counter.AddMeasure();//increment measure count
    }