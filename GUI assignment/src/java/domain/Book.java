/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

import java.io.Serializable;
import java.util.Objects;
import java.sql.Blob;

public class Book implements Serializable {
    private String BOOK_ID;
    private String BOOK_NAME;
    private Double BOOK_PRICE;
    private String AUTHOR_NAME;
    private String PUBLISHER;
    private int NO_OF_PAGE;
    private String BOOK_DESC;
    private int BOOK_QUANTITY;
    private Blob BOOK_IMAGE;
    private String BOOK_TYPE;

    public Book() {
        this(" "," ",0.0," "," ",0," ",0,null," ");
    }

    public Book(String BOOK_ID, String BOOK_NAME, Double BOOK_PRICE, String AUTHOR_NAME, String PUBLISHER, int NO_OF_PAGE, String BOOK_DESC, int BOOK_QUANTITY, Blob BOOK_IMAGE, String BOOK_TYPE) {
        this.BOOK_ID = BOOK_ID;
        this.BOOK_NAME = BOOK_NAME;
        this.BOOK_PRICE = BOOK_PRICE;
        this.AUTHOR_NAME = AUTHOR_NAME;
        this.PUBLISHER = PUBLISHER;
        this.NO_OF_PAGE = NO_OF_PAGE;
        this.BOOK_DESC = BOOK_DESC;
        this.BOOK_QUANTITY = BOOK_QUANTITY;
        this.BOOK_IMAGE = BOOK_IMAGE;
        this.BOOK_TYPE = BOOK_TYPE;
    }
    
    public String getBOOK_ID() {
        return BOOK_ID;
    }
    public void setBOOK_ID(String BOOK_ID) {
        this.BOOK_ID = BOOK_ID;
    }
    
    public String getBOOK_NAME() {
        return BOOK_NAME;
    }
    public void setBOOK_NAME(String BOOK_NAME) {
        this.BOOK_NAME = BOOK_NAME;
    }
    
    public Double getBOOK_PRICE() {
        return BOOK_PRICE;
    }
    public void setBOOK_PRICE(Double BOOK_PRICE) {
        this.BOOK_PRICE = BOOK_PRICE;
    }
    
    public String getAUTHOR_NAME() {
        return AUTHOR_NAME;
    }
    public void setAUTHOR_NAME(String AUTHOR_NAME) {
        this.AUTHOR_NAME = AUTHOR_NAME;
    }
    
    public String getPUBLISHER() {
        return PUBLISHER;
    }
    public void setPUBLISHER(String PUBLISHER) {
        this.PUBLISHER = PUBLISHER;
    }
    
    public int getNO_OF_PAGE() {
        return NO_OF_PAGE;
    }
    public void setNO_OF_PAGE(int NO_OF_PAGE) {
        this.NO_OF_PAGE = NO_OF_PAGE;
    }
    
    public String getBOOK_DESC() {
        return BOOK_DESC;
    }
    public void setBOOK_DESC(String BOOK_DESC) {
        this.BOOK_DESC = BOOK_DESC;
    }
    
    public int getBOOK_QUANTITY() {
        return BOOK_QUANTITY;
    }
    public void setBOOK_QUANTITY(int BOOK_QUANTITY) {
        this.BOOK_QUANTITY = BOOK_QUANTITY;
    }
    
    public Blob getBOOK_IMAGE() {
        return BOOK_IMAGE;
    }
    public void setBOOK_IMAGE(Blob BOOK_IMAGE) {
        this.BOOK_IMAGE = BOOK_IMAGE;
    }
    
    public String getBOOK_TYPE() {
        return BOOK_TYPE;
    }
    public void setBOOK_TYPE(String BOOK_TYPE) {
        this.BOOK_TYPE = BOOK_TYPE;
    }
    
    public String toString() {
        return  "\nBook ID: " + BOOK_ID +
                "\nBook Name: " + BOOK_NAME +
                "\nPrice: " + BOOK_PRICE +
                "\nAuthor Name: " + AUTHOR_NAME +
                "\nPublisher: " + PUBLISHER +
                "\nNo.of Page: " + NO_OF_PAGE +
                "\nDescption: " + BOOK_DESC +
                "\nQuantity: " + BOOK_QUANTITY +
                "\nImage: " + BOOK_IMAGE +
                "\nType: " + BOOK_TYPE;
    }
    
}