import java.sql.Connection;
import java.sql.DriverManager;

public class TestDB {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/fashion_streak", "root", "Anupama@123");
            System.out.println("SUCCESSFULLY CONNECTED WITH Anupama@123");
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}
