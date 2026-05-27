import com.fashionstreak.dao.ProductDao;
import com.fashionstreak.model.Product;
import java.util.List;

public class TestDao {
    public static void main(String[] args) {
        ProductDao dao = new ProductDao();
        List<Product> products = dao.getNewArrivals(8);
        System.out.println("Products found: " + products.size());
        for(Product p : products) {
            System.out.println(p.getName());
        }
    }
}
