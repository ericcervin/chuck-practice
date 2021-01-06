//chuck_practice_20210105
//sample_slicer.ck

Gain mast => JCRev jc => dac;
0.025 => jc.mix;

// tempo and counter objects
//BPM tempo;
//TheCount counter;

SndBuf bff => mast;
"sample2.wav" => string sample_file;
me.dir(-1) + "/audio/" + sample_file => bff.read;
bff.length() => now;


12 => int num_slices;
(bff.length() / 1::samp) $ int  => int buffer_len;
buffer_len / num_slices => int slice_len;

int slice_start; float slice_rate;

Event happening[num_slices];

for (0 => int i; i < num_slices; i++){
    i * slice_len => slice_start;
    0.8 => slice_rate;
    spork ~ slice(happening[i], sample_file, slice_start, slice_len,slice_rate);
    }

[[5 , 0, 7, 4,11, 6, 9,15,10, 1, 3,14,13, 2, 8,12], //P
 [11, 0, 9,12, 5,10, 7, 1, 6,15,13, 2, 3,14, 8, 4], //I
 [12, 8, 2,13,14, 3, 1,10,15, 9, 6,11, 4, 7, 0, 5], //R
 [ 4, 8,14, 3, 2,13,15, 6, 1, 7,10, 5,12, 9, 0,11]  //IR
    ] @=> int drum_rows[][];

repeat(4){      
  for (0 => int row; row < 4; row++){
      for (0 => int step; step < 16; step++){
        if (drum_rows[row][step] < num_slices){
           happening[drum_rows[row][step]].signal();
        }   
        slice_len::samp * 0.5 => now;
      }
      0.5::second=>now;
  }
}
2::second => now;
    
fun void slice(Event anEvent, string file, int start, int len, float rate){
    //SndBuf sound => Envelope env => masterEnv;
    
    SndBuf sound => Envelope env => mast;
    
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    rate => sound.rate;
    sound.samples() => sound.pos;
    0.8 => sound.gain;
    
    2.0 => env.target;
    (len * 0.5)::samp => dur rise =>  dur fall;
    
    while( true )
    {
      anEvent => now;
   
      start => sound.pos;
      rise => env.duration;
      1 => env.keyOn;
      rise=>now;
      1 => env.keyOff;
      fall=>now;
      sound.samples() => sound.pos;
    }
 }



