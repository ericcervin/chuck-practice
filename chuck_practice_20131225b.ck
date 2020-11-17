SndBuf Buff => dac;
me.dir() + "/audio/sample1.wav" => Buff.read;
-2 => float BuffRate;
BuffRate => Buff.rate;
repeat(12){
  if (BuffRate >= 0){
    0 => Buff.pos;
  } else {
    Buff.samples() => Buff.pos;
  }
  Std.fabs(BuffRate) => float absBuffRate;
  (Buff.length()/absBuffRate)=>now;
}