    /**
     * A thread that performs a GET.

     */
package org.bireme.scieloorgharvester;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.commons.httpclient.HttpStatus;
import org.bireme.scieloorgharvester.ThreadCounter;
import java.io.*;

public class GetThread extends Thread {
        
        private HttpClient httpClient;
        private GetMethod method;
        private int id;
        private String XMLName;
        private String path;
        private ThreadCounter tdc;
        private String instanceName;
        
        public GetThread(HttpClient httpClient, GetMethod method, int id, 
                String path, String XMLName, String instanceName , ThreadCounter tdc) {
            this.httpClient = httpClient;
            this.method = method;
            this.id = id;
            this.XMLName = XMLName;
            this.path = path;
            this.tdc = tdc;
            this.instanceName = instanceName;
        }
        
        /**
         * Executes the GetMethod and prints some satus information.
         */
        
        public void run() {
            String XMLContent = new String();            
            
            try {
                //executing method
                httpClient.executeMethod(method);   
                //method.getParams().setHttpElementCharset("ISO-8859-1");
                //method.getParams().setContentCharset("ISO-8859-1");
                //method.getParams().setCredentialCharset("ISO-8859-1");                
                if (method.getStatusCode() == HttpStatus.SC_OK) {                  
                    InputStream is = method.getResponseBodyAsStream();
                    BufferedInputStream bis = new BufferedInputStream(is);
                    StringBuilder responseBuffer = new StringBuilder();
                    int ch = 0;
                    while( (ch = bis.read()) > -1){
                        responseBuffer.append( (char)ch );
                    }               
                    is.close();
                    bis.close();
                    XMLContent = responseBuffer.toString();
                }                
                //replacing attribute name and uri from xml root element <collection name="Brasil" uri="http://test.scielo.br">                
                XMLContent = XMLContent.replaceFirst("<collection name.*?>","<collection name=\""+instanceName+"\" uri=\"http://"+path+"\">");
                
                //convertendo String para InputStream para validar o XML
                InputStream is = new ByteArrayInputStream(XMLContent.getBytes("ISO-8859-1"));
                 
                XMLParser.isXML(is);
                File xsd = new File("xsd/"+XMLName+".xsd");  
                
                XMLParser.validateWithSchema(xsd,XMLContent);
                
                File fl = new File(path+"/");
                if (fl.mkdirs() || fl.exists())
                {
                    //grava o XML do WS no diretorio e com o nome passados como parametro
                    BufferedWriter out = new BufferedWriter(new FileWriter(path+"/"+XMLName+".xml"));
                    System.out.println("writing in: "+path+"/"+XMLName+".xml");
                    out.write(XMLContent);
                    out.close();
                }else
                {
                    System.out.println("directory not created");
                }
                    
            }catch (Exception ex) {
                System.out.println(id + " - error: " + ex);
                System.out.println(id + " - xml: " + XMLContent);
            } finally {
                // always release the connection after we're done 
                method.releaseConnection();
                tdc.plusThreadDoneCounter();
                System.out.println(tdc.GetThreadDoneCounter());
                System.out.println(id + " - connection released");
            }
        }
       
    }