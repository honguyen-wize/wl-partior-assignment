package com.wizeline.assignments.features.simple;

import com.intuit.karate.junit5.Karate;

class AssignmentSimpleRunner {
    
    @Karate.Test
    Karate testSimpleFlow() {
        return Karate.run("assignment-deposit").relativeTo(getClass());
    }    

}
