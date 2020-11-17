SndBuf Buff => Envelope env1 => JCRev jc => dac;
me.dir() + "/audio/sample1.wav" => Buff.read;

1 => Buff.gain;

play_burst(50);
play_burst(75);
play_burst(100);
play_burst(75);
play_burst(50);
4::second => now;

fun void play_grain(dur length){
  1 => env1.target;
  length/2 => dur halfLife;
  halfLife => env1.duration;
  1 => env1.keyOn;
  halfLife => now;
  1 => env1.keyOff;
  halfLife => now;
}

fun void play_burst(int grainCount){
  repeat(grainCount){
    (Math.random2(1,(grainCount-1)) * (Buff.samples()/grainCount)) => Buff.pos;
    Math.random2f(-1,1) => Buff.rate;
    play_grain(Buff.length()/grainCount);
  }
}
