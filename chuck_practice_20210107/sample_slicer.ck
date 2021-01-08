//chuck_practice_20210107
//sample_slicer.ck

//master buffer
Gain mast => JCRev jc => dac;
0.025 => jc.mix;

// tempo and counter objects
//BPM tempo;
//TheCount counter;

64 => int num_slices;
Event happening[num_slices];

slice_file(num_slices,"sample4.wav");


1::second => now;

int slice_choice;

repeat(1024){
    Math.random2(0,num_slices-1) => slice_choice;
    if (Math.random2f(0,1) < 0.75){
     happening[slice_choice].signal();
    }
    Math.random2(25,50)::ms => now;
    }

2::second => now;
    
fun void slice(Event anEvent, string file, int start, int len, float rate){
    //SndBuf sound => Envelope env => masterEnv;
    
    SndBuf sound => Envelope env => mast;
    
    me.dir(-1) + "/audio/" + file => sound.read;//load sound file
    sound.samples() => sound.pos;
    0 => sound.rate;
    0.75 => sound.gain;
    
    1 => env.target;
    (len * 0.5)::samp => dur rise =>  dur fall;
    
    while( true )
    {
      anEvent => now;
   
      rate => sound.rate;
      start => sound.pos;
      rise => env.duration;
      1 => env.keyOn;
      rise=>now;
      1 => env.keyOff;
      fall=>now;
//      sound.samples() => sound.pos;
      0 => sound.rate;
    }
 }

fun void slice_file(int num_slices, string sample_file){
   SndBuf bff => mast;
   me.dir(-1) + "/audio/" + sample_file => bff.read;
   bff.length() => now;
   (bff.length() / 1::samp) $ int  => int buffer_len;
    buffer_len / num_slices => int slice_len;

   int slice_start; float slice_rate;

  for (0 => int i; i < num_slices; i++){
      i * slice_len => slice_start;
      0.8 => slice_rate;
      spork ~ slice(happening[i], sample_file, slice_start, slice_len,slice_rate);
      }
  repeat(2){    
    for (0 => int i; i < num_slices;i++){
        happening[i].signal();
        slice_len::samp => now;
      }
  }    
      }

