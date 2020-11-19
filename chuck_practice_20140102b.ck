SndBuf Buff => dac;
me.dir() + "/audio/sample2.wav" => Buff.read;
0.8 => Buff.rate;
repeat(8){
  repeat (3){
    repeat(3){10000 => Buff.pos; 7500::samp=>now;};
    repeat(1){30000 => Buff.pos; 7500::samp=>now;};
  }
  repeat (1){
    repeat(4){10000 => Buff.pos; 7500::samp=>now;};
  }
}