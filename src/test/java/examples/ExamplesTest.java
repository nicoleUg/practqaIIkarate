package examples;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class ExamplesTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:examples")
                //.outputCucumberJson(true)
                .parallel(5);
        assertTrue(results.getScenariosTotal() > 0, "No se ejecutaron escenarios Karate; revisar rutas y etiquetas.");
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
