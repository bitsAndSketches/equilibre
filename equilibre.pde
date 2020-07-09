public class Quili {

    PVector pos;
    int     size;
    color   c;
    color   initial_color;

    public Quili (PVector pos, int size, color initial_color) {
        this.pos = pos;
        this.size = size;
        this.initial_color = initial_color;
        this.c = initial_color;
    }

    public void display () {
        fill(c);
        rect(pos.x, pos.y, size, size);
    }

    public void update (ArrayList<Quili> neighbours) {
        if (c != initial_color) {
            int r = (c >> 16) & 0xFF;
            int g = (c >> 8) & 0xFF;
            int b = c & 0xFF;

            int new_r = r;
            int new_g = g;
            int new_b = b;

            for (int i = 0; i < neighbours.size(); ++i) {
                Quili neighbour = neighbours.get(i);
                int nr = (neighbour.c >> 16) & 0xFF;
                int ng = (neighbour.c >> 8) & 0xFF;
                int nb = neighbour.c & 0xFF; 
            }
            c = color(new_r, new_g, new_b);
        }
    }
}

int N_QUILIS = 100;
Quili[] quilis = new Quili[N_QUILIS];

int quili_size;
int n_quilis;

void setup() {
    size(500, 500);
    n_quilis = int(sqrt(N_QUILIS));
    quili_size = 500 / n_quilis;
    int i = 0;
    for (int y = 0; y < n_quilis; ++y) {
        for (int x = 0; x < n_quilis; ++x) {
            color c = i == 25 ? color(0, 255, 0) : color(255, 0, 0);
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
}
