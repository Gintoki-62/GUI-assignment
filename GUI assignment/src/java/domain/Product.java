/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package domain;

/**
 *
 * @author User
 */
import java.io.Serializable;

public class Product implements Serializable{
    private String bookId;
    private String bookName;
    private Double price;
    private String Author;
    private String publisher;
    private int no_pages;
    private String description;
    private int quantity;
    private String type;
    private String image;
    private String category;
    
    public Product(){
    }
    
    public Product(String bookId, String bookName, Double price, 
            String Author, String publisher, int no_pages, 
            String description, int quantity, String type, 
            String image, String category){
        
        this.bookId = bookId;
        this.bookName = bookName;
        this.price = price;
        this.Author = Author;
        this.publisher = publisher;
        this.no_pages = no_pages;
        this.description = description;
        this.quantity = quantity;
        this.type = type;
        this.image = image;
        this.category = category;
    }
    
    public String getBookId() {
        return bookId;
    }
    public void setBookId(String bookId) {
        this.bookId = bookId;
    }
    
    public String getBookName() {
        return bookName;
    }
    public void setBookName(String bookName) {
        this.bookName = bookName;
    }
    
    public Double getPrice() {
        return price;
    }
    public void setPrice(Double price) {
        this.price = price;
    }
    
    public String getAuthor() {
        return Author;
    }
    public void setAuthor(String Author) {
        this.Author = Author;
    }
    
    public String getPublisher() {
        return publisher;
    }
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    
    public int getNoPages() {
        return no_pages;
    }
    public void setNoPages(int no_pages) {
        this.no_pages = no_pages;
    }
    
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    
    public String getType() {
        return type;
    }
    public void setType(String type) {
        this.type = type;
    }
    
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    
}
