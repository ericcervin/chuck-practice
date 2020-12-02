//chuck_practice_20201202
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int nmID;int kickID; int shakeID;//variables to hold program IDs

140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute
counter.setMeasure(1);//set counter to first measure

Machine.add(me.dir() + "/noisemaker2.ck") => nmID;    //start program that will run throughout

repeat(30){//30 wholenote (4 beat) measures at 140 BPM
    <<<"measure ",counter.Measure>>>;
    if (counter.Measure%2==0){Machine.add(me.dir() + "/kick.ck") => kickID;}//kick plays on even measures
    if (counter.Measure%2!=0){Machine.add(me.dir() + "/shake.ck") => shakeID;}//shaker plays on odd measures
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    }

 //remove programs at end
 Machine.remove(nmID);
 Machine.remove(kickID);
 

 



    
    



    