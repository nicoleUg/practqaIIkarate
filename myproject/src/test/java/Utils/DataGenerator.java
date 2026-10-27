package Utils;

import com.github.javafaker.Faker;
import java.util.HashMap;
import java.util.Map;

public class DataGenerator {
    
    public static Map<String, Object> getUserRandom() {
        Faker faker = new Faker();
        Map<String, Object> json = new HashMap<>();
        
        String name = faker.name().firstName() + " " + faker.name().lastName();
        String email = faker.name().firstName().toLowerCase() + faker.random().nextInt(0, 1000) + "@test.com";
        
        json.put("name", name);
        json.put("gender", "male"); 
        json.put("email", email);
        json.put("status", "active"); 
        
        return json;
    }
}