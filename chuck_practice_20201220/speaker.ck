//chuck_practice_20201220
//speaker.ck

//create tempo and counter objects
BPM tempo;
TheCount counter;

Event doom; Event gloom; Event zoom; Event room;

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
spork ~ slice(doom,"sample4.wav", 24, 1000,0.8);
spork ~ slice(gloom, "sample4.wav", 1540, 1000,0.8);
spork ~ slice(zoom, "sample4.wav", 3263, 1000,0.8);
spork ~ slice(room, "sample4.wav", 5000, 700,0.8);
// then signal the event forever in a loop
while( true )
{   
   // <<<counter.Measure % 2.0>>>;
    if (counter.Measure % 2.0 != 0) {
       repeat(2){
         Math.random2f(0,1.0) => float chance;
         if (chance < 0.25){doom.signal();} 
         else if (chance >= 0.25 && chance < 0.5){gloom.signal();}
         else if (chance >= 0.5 && chance < 0.75){zoom.signal();}
         else {room.signal();}
         // advance time
         (8 * tempo.sixteenthNote)  => now;
       }
    }
    else {tempo.wholeNote => now;}
}
