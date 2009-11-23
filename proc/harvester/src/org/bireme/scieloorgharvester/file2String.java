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

public class file2String {
    public static void main(String [] args) throws IOException{
        file2String(new File(args[0]),"ISO-8859-1"); 
    }
    
    /** Creates a new instance of file2String */
   public static String file2String(File file, String encoding) throws IOException{
        FileInputStream fl = new FileInputStream(file);
        InputStreamReader is = new InputStreamReader(fl,encoding);
        BufferedReader br  = new BufferedReader(is);
        StringBuilder sb = new StringBuilder();
        String line = null;
        while(true) {
            line = br.readLine();
            //System.out.println("---------------------------------\n"+line);
            if (line == null) {
                break;
            }
            sb.append(line);
        }
        is.close();    
        //System.out.println("teste "+sb.toString());
        return sb.toString();
   }
}
