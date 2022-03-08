Mover[] movers = new Mover[100]; // fireflies
ArrayList<Attractor> attractors = new ArrayList<Attractor>(); // light sources

void setup() {
  size(1200, 900);
  // attractors.add(new Attractor(width/2, height/2));

  for (int i = 0; i < movers.length; i++) {
    // Each Mover is initialized randomly.
    movers[i] = new Mover(random(0.1, 2), // mass
      random(width), random(height)); // initial location
  }
}

void draw() {
  background(255, 255, 255);
  // fill(255, 10);
  // rect(0, 0, width, height);

  // For each mover
  for (int i = 0; i < movers.length; i++) {

    // Apply the attraction force from the attractors on this mover
    for (int j = 0; j < attractors.size(); j++) {
      PVector aForce = attractors.get(j).attract(movers[i]);
      movers[i].applyForce(aForce);
      attractors.get(j).display();
    }

    // Now apply the force from all the other movers on this mover
    for (int j = 0; j < movers.length; j++) {
      // Don’t attract yourself!
      if (i != j) {
        PVector force = movers[j].attract(movers[i]);
        movers[i].applyForce(force);
      }
    }

    movers[i].update();
    movers[i].display();
    movers[i].checkEdges();
  }
}

void mousePressed() {
  attractors.add(new Attractor(mouseX, mouseY));
}



class Attractor {
  float mass;
  PVector location;
  float G;

  Attractor(int _x_, int _y_) {
    location = new PVector(_x_, _y_);

    // Big mass so the force is greater than vehicle-vehicle force
    // You can play with this number to see different results
    mass = 30;
    G = 0.4;
  }

  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    // Remember, we need to constrain the distance
    // so that our vehicle doesn’t spin out of control.
    distance = constrain(distance, 5.0, 25.0);

    force.normalize();
    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);
    return force;
  }

  void display() {
    fill(255,255,153);
    ellipse(location.x, location.y, mass*2, mass*2);
  }
}



class Mover {

  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  float G = 0.4;
  float myColor;

  Mover(float _mass_, float _x_, float _y_) {
    mass = _mass_;
    location = new PVector(_x_, _y_);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    myColor = random(255);
  }

  // Newton’s second law.
  void applyForce(PVector force) {
    // Receive a force, divide by mass, and add to acceleration.
    PVector f = PVector.div(force, mass);
    acceleration.add(f);
  }

  // The Mover now knows how to attract another Mover.
  PVector attract(Mover m) {
    PVector force = PVector.sub(location, m.location);
    float distance = force.mag();
    distance = constrain(distance, 5, 20.0);
    force.normalize();

    float strength = (G * mass * m.mass) / (distance * distance);
    force.mult(strength);

    return force;
  }

  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }

  void display() {
    stroke(0);
    fill (myColor);

    // Rotate the mover to point in the direction of travel
    // Translate to the center of the move
    pushMatrix();
    translate(location.x, location.y);
    rotate(velocity.heading());
    // It took lots of trial and error
    // and sketching on paper
    // to get the triangle
    // pointing in the right direction
    triangle(0, 5, 0, -5, 20, 0);
    popMatrix();
  }

  // With this code an object bounces when it hits the edges of a window.
  // Alternatively objects could vanish or reappear on the other side
  // or reappear at a random location or other ideas. Also instead of
  // bouncing at full-speed vehicles might lose speed. So many options!
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.8; // lose a bit of energy in the bounce
    } else if (location.x < 0) {
      location.x = 0;
      velocity.x *= -1; // full velocity, opposite direction
      velocity.x *= 0.8; // lose a bit of energy in the bounce
    }

    if (location.y > height) {
      location.y = height;
      velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.8; // lose a bit of energy in the bounce
    } else if (location.y < 0) {
      location.y = 0;
      velocity.y *= -1; // full velocity, opposite direction
      velocity.y *= 0.8; // lose a bit of energy in the bounce
    }
  }
}
