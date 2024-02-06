package com.wizeline.assignments;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

class AssignmentsTest {

    @Test
    void testParallel() {
        Results results = Runner.path("classpath:com/wizeline/assignments/features")
                .parallel(1);
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }

}
