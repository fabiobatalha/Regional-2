/*
 * ThreadCounter.java
 *
 * Created on 10 de Março de 2006, 14:28
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

package org.bireme.scieloorgharvester;

/**
 *
 * @author Santos
 */
public class ThreadCounter {
    private int ThreadDoneCounter;
    private int ThreadTotal;
    private Object monitor;
    
    /** Creates a new instance of ThreadCounter */
    public ThreadCounter() {
    }
  
    public int GetThreadDoneCounter(){
        return this.ThreadDoneCounter;
    }    
    
    public void  SetThreadTotal(int total){
        this.ThreadTotal = total;
    }       
    
    public void plusThreadDoneCounter(){        
        System.out.println("atual "+this.ThreadDoneCounter+" total "+this.ThreadTotal);
        
        synchronized(this) {
            this.ThreadDoneCounter++;
            if (ThreadDoneCounter == ThreadTotal){
                System.out.println("running notifyall");
                notify();
            }    
        }
    }    
    
    
    
}
