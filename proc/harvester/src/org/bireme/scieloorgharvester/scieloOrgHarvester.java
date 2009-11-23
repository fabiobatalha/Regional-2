package org.bireme.scieloorgharvester;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.MultiThreadedHttpConnectionManager;
import org.apache.commons.httpclient.methods.GetMethod;
import org.bireme.scieloorgharvester.*;
import java.io.*;
import java.io.OutputStream;
import java.util.Properties;
import java.util.*;

/**
 * @author Batalha, Fabio
 */
public class scieloOrgHarvester {  
     /**
     * Constructor for MultiThreadedExample.
     */
    public scieloOrgHarvester() {
        super();
        //Properties p = System.getProperties(); verify System Properties variables
        //p.list(System.out);
    }

    public static void main(String[] args) {
        scieloOrgHarvester soh = new scieloOrgHarvester();
        soh.execute();
    }
    
    public void execute() {
        ThreadCounter tdc = new ThreadCounter();        
        File fl = new File("collection.txt");
        //File webservicesFile = new File("webservices.txt");
        file2Array f2a = new file2Array();
        //file2Array webservicesList = new file2Array();
        file2String f2s = new file2String();        
        XMLParser xp = new XMLParser();
        // Create an HttpClient with the MultiThreadedHttpConnectionManager.
        // This connection manager must be used if more than one thread will
        // be using the HttpClient.
        HttpClient httpClient = new HttpClient(new MultiThreadedHttpConnectionManager());    
        // Set the default host/protocol for the methods to connect to.
        // This value will only be used if the methods are not given an absolute URI
        //httpClient.getHostConfiguration().setHost("scielo.dev", 80, "http");        
        
        try{           
            String[][] urisToGet = f2a.file2Array(fl);
            tdc.SetThreadTotal(urisToGet.length);
            // create a thread for each URI
            GetThread[] threads = new GetThread[urisToGet.length];
            System.out.println(urisToGet.length);
            for (int i = 0; i < threads.length; i++) {
                GetMethod get = new GetMethod(urisToGet[i][0]);
                get.setFollowRedirects(true);
                threads[i] = new GetThread(httpClient, get, i + 1,urisToGet[i][1],urisToGet[i][3],urisToGet[i][4] ,tdc);
            }
        
            // start the threads
            for (int j = 0; j < threads.length; j++) {
                threads[j].start();
            }
//espera todas as threads terminarem de ler e gravas os XML dos WSs              
            synchronized(tdc){
                tdc.wait();
            }
//gera uma lista distinta dos servicos que estao no collection.txt
            List webservices = new ArrayList();
//gera uma Lista distinta dos diretorios das coleções            
            List diretorios = new ArrayList();
            
            for(int i = 0; i < urisToGet.length; i++)
            {
                String [] x = {urisToGet[i][2],urisToGet[i][3],urisToGet[i][4]};
                if(! webservices.contains(x) )
                    webservices.add(x);
            }
            
            for(int i = 0; i < urisToGet.length; i++)
            {
                if(! diretorios.contains(urisToGet[i][1]) )
                    diretorios.add(urisToGet[i][1]);
            }
            
//array com os XMLs concatenados por servico
            String [] xmls = new String[webservices.size()];
//array bi-dimensional: 1 servicos - n XMLs
            String [][] xml = new String[webservices.size()][diretorios.size()];
//cria uma array de XML gravados pelas threads
            for (int i=0 ; i < webservices.size() ; i++)
            {
                for(int j=0; j < diretorios.size(); j++)
                {
                    String [] instanceData = (String [])webservices.get(i);
                    String diretorio = (String)diretorios.get(j);

                    File xmlFile = new File(diretorio +"/"+ instanceData[1] + ".xml");    
                    if (xmlFile.exists()){
                        xml[i][j] = f2s.file2String(xmlFile,"ISO-8859-1");  
                        xml[i][j] = xp.removeXmlHeader(xml[i][j]);
                    }
                }
                xmls[i] = xp.concat(xml[i]);
             }
//para cada webservice, pega a lista de arquivos gerados por cada instancia, concatena
//aplica uma XSL para gerar o RSS correto e grava no diretorio xml
            for (int i=0 ; i < webservices.size(); i++){
                String joinedXML = new String();
                String [] s = (String [])webservices.get(i);
                if (fl.mkdirs() || fl.exists())
                {
                    BufferedWriter out = new BufferedWriter(new FileWriter("xml/"+ s[1] + ".xml"));
                    joinedXML = "<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n";
                    joinedXML +="<collectionList>";
                    joinedXML += xp.removeXmlHeader(xp.XMLParser(xmls[i],"xsl/"+s[0]+".xsl"));
                    joinedXML +="</collectionList>";
                    out.write(joinedXML);
                    out.close();
                }  
                System.out.println(s[1]+"Done!! \n");
            }  
        }
        catch (java.io.FileNotFoundException ex){
            System.out.println("Exeception: "+ex);
            ex.printStackTrace();
        }
        catch (java.io.IOException ex){
            System.out.println("Exeception: "+ex);
            ex.printStackTrace();
        }        
        catch (Exception ex){
            System.out.println("Exeception: "+ex);
            ex.printStackTrace();
        }        
    }
    
}