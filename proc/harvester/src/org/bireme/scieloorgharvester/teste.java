/*
 * teste.java
 *
 * Created on 26 de Junho de 2006, 14:40
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package org.bireme.scieloorgharvester;


import java.io.File;
import javax.xml.XMLConstants;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Schema;
import javax.xml.validation.Validator;
/**
 *
 * @author fabio.santos
 */
public class teste {
    
    /** Creates a new instance of teste */
    public static void main (String [] args) {
        
        SchemaFactory schemaFactory =
            SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        Source schemaSource = new StreamSource(new File("xsd/get_titles.xsd"));
        
        try{
        Schema schema = schemaFactory.newSchema(schemaSource);
        
        Validator validator = schema.newValidator();
        validator.validate(new StreamSource("xml/teste.xml"));
        
        }catch (Exception e){
            System.out.println(e);
        }
    }  
}
