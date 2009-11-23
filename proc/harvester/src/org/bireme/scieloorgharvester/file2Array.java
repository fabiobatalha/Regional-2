/*
 * file2String.java
 *
 * Created on 23 de Novembro de 2005, 10:04
 *
 * To change this template, choose Tools | Options and locate the template under
 * the Source Creation and Management node. Right-click the template and choose
 * Open. You can then make changes to the template in the Source Editor.
 */

/**
 *
 * @author Santos
 */
package org.bireme.scieloorgharvester;

import java.io.*;

public class file2Array {
    /** Creates a new instance of file2String */
    public file2Array() {
      
    }
 
    public String[][] file2Array(File file) throws IOException{
        BufferedReader br  = new BufferedReader(new InputStreamReader (new FileInputStream(file)));
        BufferedReader br1  = new BufferedReader(new InputStreamReader (new FileInputStream(file)));
        StringBuilder sb = new StringBuilder();
        String line = null;      
        int x=0;
        while(true) {           
            line = br1.readLine();
            if ((line == null)) {
                break;
            }
            if (line.startsWith("#")){
                continue;
            }
            x++;   
        }     
        String [][] urisToGet = new String[x][];
        x=0;
        while(true) {           
            line = br.readLine();
            if (line == null) {
                break;
            }
            if (line.startsWith("#")){
                continue;
            }
            urisToGet[x] = new String[3];
            urisToGet[x] = line.split(",");
            x++;
        }
        //System.out.println(sb.toString());
        return urisToGet;
    }
   }