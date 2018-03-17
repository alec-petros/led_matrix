import codeanticode.syphon.*;

PGraphics canvas;
SyphonClient client;
OPC opc;
PShader blur;

public void setup() {
  size(800, 300, P3D);
  colorMode(HSB, 100);
  frameRate(30);

  blur = loadShader("blur.glsl");


  opc = new OPC(this, "fade.local", 7890);
  opc.ledStrip(0 * 31, 31, width * 0.5, height * 0/8 + height * 1/16, width / 32, 0, false);
  opc.ledStrip(1 * 31, 31, width * 0.5, height * 1/8 + height * 1/16, width / 32, 0, true);
  opc.ledStrip(2 * 31, 31, width * 0.5, height * 2/8 + height * 1/16, width / 32, 0, false);
  opc.ledStrip(3 * 31, 31, width * 0.5, height * 3/8 + height * 1/16, width / 32, 0, true);
  opc.ledStrip(4 * 31, 31, width * 0.5, height * 4/8 + height * 1/16, width / 32, 0, false);
  opc.ledStrip(5 * 31, 31, width * 0.5, height * 5/8 + height * 1/16, width / 32, 0, true);
  opc.ledStrip(6 * 31, 30, width * 0.5, height * 6/8 + height * 1/16, width / 32, 0, false);
  opc.ledStrip(7 * 31 - 1, 30, width * 0.5, height * 7/8 + height * 1/16, width / 32, 0, true);
  println("Available Syphon servers:");
  println(SyphonClient.listServers());

  // Create syhpon client to receive frames
  // from the first available running server:
  client = new SyphonClient(this);

  // A Syphon server can be specified by the name of the application that it contains it,
  // its name, or both:

  // Only application name.
  //client = new SyphonClient(this, "SendFrames");

  // Both application and server names
  //client = new SyphonClient(this, "SendFrames", "Processing Syphon");

  // Only server name
  //client = new SyphonClient(this, "", "Processing Syphon");

  // An application can have several servers:
  //client = new SyphonClient(this, "Quartz Composer", "Raw Image");
  //client = new SyphonClient(this, "Quartz Composer", "Scene");

}

public void draw() {
  background(0);
  if (client.newFrame()) {
    canvas = client.getGraphics(canvas);
    image(canvas, 0, 0, width, height);
  }
  filter(blur);
}

void keyPressed() {
  if (key == ' ') {
    client.stop();
  } else if (key == 'd') {
    println(client.getServerName());
  }
}
