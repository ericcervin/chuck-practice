SndBuf Buff => JCRev jc => JCRev jc2 => dac;
me.dir() + "/audio/sample1.wav" => Buff.read;
-0.5 => float BuffRate;
BuffRate => Buff.rate;
0.5 => jc.mix => jc2.mix;
repeat(3){
  if (BuffRate >= 0){
    0 => Buff.pos;
  } else {
    Buff.samples() => Buff.pos;
  }
  Std.fabs(BuffRate) => float absBuffRate;
  (Buff.length()/absBuffRate)=>now;
  }
4::second => now;