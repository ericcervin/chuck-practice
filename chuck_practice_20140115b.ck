"Sample2.wav" => string fileName;

[
 [0.250000, 1.000000],
 [0.125000, 0.500000],
 [0.062500, 0.250000],
 [0.031250, 0.125000],
 [0.015625, 0.062500],
 [0.007813, 0.031250],
 [0.003906, 0.015625],
 [0.001953, 0.007813],
 [0.000977, 0.003906],
 [0.000488, 0.001953],
 [0.000244, 0.000977],
 [0.000122, 0.000488],
 [0.000061, 0.000244],
 [0.000031, 0.000122],
 [0.000015, 0.000061]
] @=> float delays[][];

SndBuf biff[delays.cap()];

spork~ play_aud(1, fileName, 0);

for (1 => int i; i < delays.cap(); i++){
  delays[i][0]::second => now;
  spork~ play_aud(delays[i][1], fileName, i);
}

40::second => now;

fun void play_aud(float buffGain, string fileName, int buffNum){
  biff[buffNum] => dac;
  buffGain => biff[buffNum].gain;
  me.dir() + "/audio/" + fileName => biff[buffNum].read;
  1 => biff[buffNum].loop;
  40::second => now;
}
