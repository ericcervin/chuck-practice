//chuck_practice_20210121
//score.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

int ssID;
140 => float beat; //140 Beats per minute
tempo.tempo(beat); //140 Beats per minute

Machine.add(me.dir() + "/sample_slicer.ck") => ssID;
