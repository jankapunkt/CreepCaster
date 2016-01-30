//----------------------------------------
// HERE COMES ALL AUDIO STUFF
//
//  API DOCUMENTATION: http://code.compartmental.net/minim/
//
//----------------------------------------
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

public final Minim minim = new Minim(this); //sound card interface
public AudioPlayer bgAudio;

public AudioSample spawnFx;

public boolean bgIsPlaying = false;

public void setupAudio()
{
  bgAudio = minim.loadFile("bgDummy.mp3");
  bgAudio.setGain(0.3f);
  bgAudio.loop(5);
  spawnFx = minim.loadSample("spawn.mp3");
}


public void updateAudio()
{
  if (!bgIsPlaying)
  {
    bgAudio.play();
    bgIsPlaying = true;
  }
  
}