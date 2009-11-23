package org.bireme.scieloorgharvester;

import java.io.*;

import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.parsers.SAXParser;
import javax.xml.validation.Schema;
import org.xml.sax.helpers.DefaultHandler;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;
import javax.xml.XMLConstants;
import javax.xml.validation.SchemaFactory;
import javax.xml.validation.Validator;

public class XMLParser extends DefaultHandler{
    
    public String XMLParser(String xml, String xsl) {
        String result = "";
        StringWriter sw = new StringWriter();
        TransformerFactory tFactory = TransformerFactory.newInstance();
        //fazendo o SAXON 8.7.1 ser o padrão ao invéz de usar Xalan
        System.setProperty("javax.xml.transform.TransformerFactory", "net.sf.saxon.TransformerFactoryImpl");
        try{
            System.out.println("starting transform");
            Transformer transformer = tFactory.newTransformer(new StreamSource(xsl)); //xsl
            transformer.transform(new StreamSource(new StringReader(xml)), new StreamResult(sw));
            System.out.println("transform finished");
        } catch (TransformerException e){
            result = result + "TransformerException: " + e.getMessage();
            e.printStackTrace();
        } catch (Exception e){
            result = result + "Exception: " + e.getMessage();
            e.printStackTrace();
        }
        System.err.println(result);
        return sw.toString();
    }
    
    public static String removeXmlHeader(String xml){
        String output;
        
        if ( xml.startsWith("<?xml") ){
            output = xml.substring( xml.indexOf("?>")+2 );
        }else{
            output = xml;
        }
        
        return output;
    }
    
    public static String concat(String[] xmlList){
        String xml = new String();
        
        xml=("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?>\n<ROOT>");
        for (int i=0; i < xmlList.length ; i++){
            xml += xmlList[i];
        }
        xml+="</ROOT>";
        return xml;
    }
    
    public static void isXML(InputStream input) throws Exception{
        
        // Instantiate an error handler
        XMLParser util = new XMLParser();
        // Standard way of creating an XMLReader in JAXP
        SAXParserFactory factory= SAXParserFactory.newInstance();
        
        // Turn on validation.
        factory.setValidating(true);
        // Get an XMLReader.
        SAXParser parser = factory.newSAXParser();
        
        parser.parse(input, util);
    }
    
    public static void validateWithSchema(File xsdFile, String xml) throws Exception{
        SchemaFactory schemaFactory =
                SchemaFactory.newInstance(XMLConstants.W3C_XML_SCHEMA_NS_URI);
        ///Source schemaSource = new StreamSource(new File("xsd/get_titles.xsd"));
        Schema schema = null;
        Validator validator = null;
        System.out.println(xsdFile.getAbsolutePath());
        schema = schemaFactory.newSchema(xsdFile);
        validator = schema.newValidator();
        validator.validate(new StreamSource(new StringReader(xml)));
    }
    
}
