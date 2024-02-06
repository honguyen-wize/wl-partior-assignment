package com.wizeline.assignments.features.complex;

import com.intuit.karate.junit5.Karate;

class AssignmentComplexRunner {
    
    @Karate.Test
    Karate testComplexFlow() {
        return Karate.run("assignment-3772").relativeTo(getClass());
    }    

}
