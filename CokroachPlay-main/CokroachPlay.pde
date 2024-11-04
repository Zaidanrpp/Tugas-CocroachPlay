
import ddf.minim.*; // Tambahkan pustaka Minim untuk efek suara

ArrayList<Roach> coks;
PImage img;
Minim minim;
AudioPlayer hitSound;
int lastSpawnTime = 0;

void setup() {
  size(800, 800);
  coks = new ArrayList<Roach>();
  img = loadImage("kecoa.png");
  
  minim = new Minim(this);
  hitSound = minim.loadFile("Hit_Hurt.wav"); // Pastikan file suara "hit.mp3" ada di folder data
}

void draw() {
  background(#15CBBE);
  textAlign(CENTER); // Buat teks berada di tengah secara horizontal
  fill(255); // Warna putih untuk teks
  textSize(32); // Ukuran teks
  text("Zaidan Rifky Putra Pratama 22.11.4902", width / 2, 50); // Posisi di atas layar, pusat
  
  // Tambahkan kecoa otomatis setiap 5 detik
  if (millis() - lastSpawnTime > 5000) {
    addRandomRoach();
    lastSpawnTime = millis();
  }
  
  // Menampilkan semua kecoa
for (int i = coks.size() - 1; i >= 0; i--) {
    Roach c = coks.get(i);
    c.live();
  }

  fill(51);
  textSize(16);
  text("nums: " + coks.size(), 50, 750); 
}

// Fungsi untuk menambahkan kecoa di posisi acak
void addRandomRoach() {
  float randomX = random(width);
  float randomY = random(height);
  coks.add(new Roach(img, randomX, randomY));
}


void mouseClicked() {
  boolean hit = false;
  
  // Periksa apakah klik mengenai salah satu kecoa
  for (int i = coks.size() - 1; i >= 0; i--) {
    Roach c = coks.get(i);
    if (dist(mouseX, mouseY, c.pos.x, c.pos.y) < img.width / 2) {
      coks.remove(i); // Hapus kecoa dari ArrayList
      hit = true;
      break;
    }
  }
  
  // Mainkan efek suara
  if (hit) {
    hitSound.rewind();
    hitSound.play();
  }
}
