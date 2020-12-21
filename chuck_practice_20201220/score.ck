//chuck_practice_20201220
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int kickID; int tomsID;int gcID;int mtID;int plsID;int spID;//variables to hold program IDs

140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure



Machine.add(me.dir() + "/grain_cloud.ck") => gcID;
Machine.add(me.dir() + "/metal_09.ck") => mtID;
Machine.add(me.dir() + "/kick_09.ck") => kickID;
Machine.add(me.dir() + "/pulse.ck") => plsID;
Machine.add(me.dir() + "/speaker.ck") => spID;


repeat(35){//35 wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    
    if (counter.Measure == 34){
        Machine.remove(kickID);
        Machine.remove(mtID);
        Machine.remove(plsID);
        Machine.remove(gcID);
        Machine.remove(spID);}
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    }




 



    
    



    