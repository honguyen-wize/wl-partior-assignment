package assignments.assignmentsimple;

import com.intuit.karate.junit5.Karate;

class AssignmentSimpleRunner {
    
    @Karate.Test
    Karate testUsers() {
        // return Karate.run("assignment-3129-demo").relativeTo(getClass());
        return Karate.run("assignment-deposit").relativeTo(getClass());
    }    

}
