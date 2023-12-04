package Repository;

import java.util.List;

public interface WalletsOperation<Z> {
    List<Z> findAll();
    Z save (Z save);
    Z delete (Z delete);
    Z update (Z update);
}
