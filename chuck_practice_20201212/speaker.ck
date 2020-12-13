//chuck_practice_20201212
//speaker.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

Event oblique; Event killer; Event bees; Event swarm;

fun int msToSamples(int millis){
    return ((millis / 1000.0) * 44100) $ int;
    }

fun void slice(Event anEvent, string file, int start, int len, float rate){
    SndBuf sound => dac;
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    rate => sound.rate;
    sound.samples() => sound.pos;
    0.8 => sound.gain;
    while( true )
    {
      anEvent => now;
   
      msToSamples(start) => sound.pos;
      len::ms=> now;
      sound.samples() => sound.pos;
    }
 }
 
 // spork
spork ~ slice(oblique,"sample2.wav", 86, 754,0.9);
spork ~ slice(killer, "sample2.wav", 916, 470,0.9);
spork ~ slice(bees, "sample2.wav", 1400, 318,0.9);
spork ~ slice(swarm, "sample2.wav", 1773, 1442,0.95);
// then signal the event forever in a loop
while( true )
{
    if (counter.Measure % 2 == 0) {
       tempo.sixteenthNote => now;
       swarm.signal();
       // advance time
       (15 * tempo.sixteenthNote) => now;}
    else    
    {
            Math.random2f(0,1.0) => float choice;
            if (choice <= 0.33){
                oblique.signal();
                tempo.halfNote => now; 
                Math.random2f(0,1.0) => float choice2;
                if (choice2 < 0.33){
                    killer.signal();}
                else if (choice2 > 0.33 && choice2 < 0.66){ 
                    bees.signal();}
                else {
                    oblique.signal();
                    }
                }
            else if (choice > 0.33 && choice < 0.66){
                killer.signal();
                tempo.halfNote => now; 
                Math.random2f(0,1.0) => float choice2;
                if (choice2 < 0.5){
                    killer.signal();
                    }
                else { 
                    bees.signal();}
                }
            else {
                bees.signal(); 
                tempo.halfNote => now; 
                bees.signal();
                } 
            tempo.halfNote => now;
            
        //tempo.wholeNote => now;
        }
    
}
