//chuck_practice_20201205
//speaker.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

Event oblique; Event killer; Event bees; Event swarm;

fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

fun void slice(Event anEvent, string file, int start, int len){
    SndBuf sound => dac;
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    sound.samples() => sound.pos;
    while( true )
    {
      anEvent => now;
      
      Math.random2f(0.4,0.8) => sound.gain;// vary loudness on each kick
      msToSamples(start) => sound.pos;
      len::ms=> now;
      sound.samples() => sound.pos;
    }
 }
 
 // spork
spork ~ slice(oblique,"sample2.wav", 86, 754 );
spork ~ slice(killer, "sample2.wav", 916, 470 );
spork ~ slice(bees, "sample2.wav", 1400, 318 );
spork ~ slice(swarm, "sample2.wav", 1773, 1442 );
// then signal the event forever in a loop
while( true )
{
    if (counter.Measure % 2 == 0) {
       // fire the next signal
       tempo.sixteenthNote => now;
       swarm.signal();
       // advance time
       (15 * tempo.sixteenthNote) => now;}
    else    
    {
        repeat(2){
            Math.random2f(0,1.0) => float choice;
            if (choice <= 0.33){oblique.signal();}
            else if (choice > 0.33 && choice < 0.66){killer.signal();}
            else {bees.signal();} 
            tempo.halfNote => now;
            }
        //tempo.wholeNote => now;
        }
    
}
