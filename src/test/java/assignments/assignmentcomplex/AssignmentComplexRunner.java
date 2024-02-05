package assignments.assignmentcomplex;

import com.intuit.karate.junit5.Karate;

class AssignmentComplexRunner {
    
    @Karate.Test
    Karate testUsers() {
        return Karate.run("assignment-3772").relativeTo(getClass());
    }    

}
