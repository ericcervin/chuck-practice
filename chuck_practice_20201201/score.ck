//chuck_practice_20201201
//score.ck

int kickID;int cowID;int sineID;int highID;int shakeID; //declare variables

BPM tempo;
TheCount counter;

tempo.tempo(140); //140 BPM = 0.429 seconds per beat
counter.setMeasure(1);//set counter to first measure




repeat(11){//play 11 measures
    <<<"measure ",counter.Measure>>>;
    //bringing in the instruments one at a time. 
    if (counter.Measure == 1){Machine.add(me.dir() + "/cow.ck") => cowID;}//More Cowbell!! starting at first measure
    if (counter.Measure == 2){Machine.add(me.dir() + "/kick.ck") => kickID;}//kick starts on second measure
    //if (counter.Measure == 3){Machine.add(me.dir() + "/shake.ck") => shakeID;}//start shaker in third measure
    if (counter.Measure == 4){Machine.add(me.dir() + "/highhat.ck") => highID;}//start highhat in fourth measure
    if (counter.Measure == 5){Machine.add(me.dir() + "/sine.ck") => sineID;}//start sine in fifth measure
    tempo.wholeNote=> now;//each measure one whole note in length
    counter.AddMeasure();//increment measure count
    
}
tempo.tempo(.25);//slow tempo so drums/bass won't continue
5::second => now;//let reverb fade smoothly

//Stop kickin' & shakin' & etc. 
Machine.remove(kickID);
Machine.remove(shakeID);
Machine.remove(highID);
Machine.remove(sineID);
//Less Cowbell!!!
Machine.remove(cowID);