color TARGET_COLOR = color(125);
int N_QUILIS = 250000;
Quili[] quilis = new Quili[N_QUILIS];

int quili_size;
int n_quilis;

void setup() {
    size(1000, 1000);
    n_quilis = int(sqrt(N_QUILIS));
    quili_size = 1000 / n_quilis;
    int i = 0;
    for (int y = 0; y < n_quilis; ++y) {
        for (int x = 0; x < n_quilis; ++x) {
            // color c = color(int(noise(i + 2) * 255), int(noise(i + 3) * 255), int(noise(i + 4) * 255));
            color c = color(int(random(255)), int(random(255)), int(random(255)));
            PVector pos = new PVector(x * quili_size, y * quili_size);
            quilis[i] = new Quili(pos, quili_size, c);
            i++;
        }
    }
}

ArrayList<Quili> get_neighbours(Quili[] quilis, int i) {
    n_quilis = int(sqrt(N_QUILIS)); // TODO: reuse
    ArrayList<Quili> neighbours = new ArrayList<Quili>();
    if (i != 0 && i % n_quilis != 1) {
        neighbours.add(quilis[i - 1]);
    }
    if (i > n_quilis) {
        neighbours.add(quilis[i - n_quilis]);
    }
    if (i != N_QUILIS - 1 && i % n_quilis != 0) {
        neighbours.add(quilis[i + 1]);
    }
    if (i < N_QUILIS - n_quilis) {
        neighbours.add(quilis[i + n_quilis]);
    }
    return neighbours;
}

void draw() {
    for (int i = 0; i < N_QUILIS; ++i) {
        
        ArrayList<Quili> neighbours = get_neighbours(quilis, i);
        quilis[i].update(neighbours);
        quilis[i].display();
    }
    saveFrame("output/equilibre-####.png");
}
