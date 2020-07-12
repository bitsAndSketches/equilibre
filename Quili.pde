public class Quili {

    PVector pos;
    int     size;
    color   c;
    color   target;

    public Quili (PVector pos, int size, color initial_color) {
        this.pos = pos;
        this.size = size;
        this.c = initial_color;
        this.target = getTargetColor(this.c);
    }

    private color getTargetColor(color c) {
        int r = (c >> 16) & 0xFF;
        int g = (c >> 8) & 0xFF;
        int b = c & 0xFF;

        return color(255 - r, 255 - g, 255 -b);
    }

    public void display () {
        fill(c);
        noStroke();
        rect(pos.x, pos.y, size, size);
    }

    public void update (ArrayList<Quili> neighbours) {
        if (c != this.target) {
            int r = (c >> 16) & 0xFF;
            int g = (c >> 8) & 0xFF;
            int b = c & 0xFF;

            int ir = (this.target >> 16) & 0xFF;
            int ig = (this.target >> 8) & 0xFF;
            int ib = this.target & 0xFF;

            int new_r = r;
            int new_g = g;
            int new_b = b;

            for (int i = 0; i < neighbours.size(); ++i) {
                Quili neighbour = neighbours.get(i);
                int nr = (neighbour.c >> 16) & 0xFF;
                int ng = (neighbour.c >> 8) & 0xFF;
                int nb = neighbour.c & 0xFF;

                if (ir > r && nr > 4) {
                    nr -= 5;
                    new_r += 5;
                } else if (ir < r && nr < 250) {
                    nr += 5;
                    new_r -= 5;
                }

                if (ig > g && ng > 4) {
                    ng -= 5;
                    new_g += 5;
                } else if (ig < g && ng < 250) {
                    ng += 5;
                    new_g -= 5;
                }

                if (ib > b && nb > 4) {
                    nb -= 5;
                    new_b += 5;
                } else if (ib < b && nb < 250) {
                    nb += 5;
                    new_b -= 5;
                }
                
                color new_neighbour_c = color(nr, ng, nb);
                neighbour.c = new_neighbour_c;
            }
            c = color(new_r, new_g, new_b);
        }
    }
}