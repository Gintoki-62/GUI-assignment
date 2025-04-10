/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import domain.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class bookDB {
    private String host = "jdbc:derby://localhost:1527/bookLoomDB";
    private String user = "book";
    private String password = "book";
    private String tableName = "BOOK";
    private Connection conn;
    private PreparedStatement stmt;

    public bookDB() {
        createConnection();
    }

    public List<Book> getRecord() {
        List<Book> bookList = new ArrayList<>();
        String queryStr = "SELECT * FROM " + tableName;

        try {
            stmt = conn.prepareStatement(queryStr);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Book book = new Book(
                    rs.getString("BOOK_ID"),
                    rs.getString("BOOK_NAME"),
                    rs.getDouble("BOOK_PRICE"),
                    rs.getString("AUTHOR_NAME"),
                    rs.getString("PUBLISHER"),
                    rs.getInt("NO_OF_PAGES"),
                    rs.getString("BOOK_DESC"),
                    rs.getInt("BOOK_QUANTITY"),
                    rs.getString("BOOK_TYPE"),
                    rs.getString("BOOK_IMAGE"),
                    rs.getString("BOOK_CATEGORY")
                );
                bookList.add(book);
            }
        } catch (SQLException ex) {
            System.err.println("Error fetching records: " + ex.getMessage());
        }
        return bookList;
    }

    private void createConnection() {
        try {
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
        } catch (SQLException ex) {
            System.err.println("Connection error: " + ex.getMessage());
        }
    }

    private void shutDown() {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException ex) {
                System.err.println("Shutdown error: " + ex.getMessage());
            }
        }
    }

    public List<Book> searchBooks(String searchTerm) {
        List<Book> books = new ArrayList<>();
        try {
            String sql = "SELECT * FROM BOOK WHERE LOWER(BOOK_NAME) LIKE ? OR LOWER(BOOK_DESC) LIKE ? OR LOWER(AUTHOR_NAME) LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            String likeTerm = "%" + searchTerm.toLowerCase() + "%";
            ps.setString(1, likeTerm);
            ps.setString(2, likeTerm);
            ps.setString(3, likeTerm);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Book book = new Book(
                    rs.getString("BOOK_ID"),
                    rs.getString("BOOK_NAME"),
                    rs.getDouble("BOOK_PRICE"),
                    rs.getString("AUTHOR_NAME"),
                    rs.getString("PUBLISHER"),
                    rs.getInt("NO_OF_PAGES"),
                    rs.getString("BOOK_DESC"),
                    rs.getInt("BOOK_QUANTITY"),
                    rs.getString("BOOK_TYPE"),
                    rs.getString("BOOK_IMAGE"),
                    rs.getString("BOOK_CATEGORY")
                );
                books.add(book);
            }
        } catch (SQLException ex) {
            System.err.println("Search error: " + ex.getMessage());
        }
        return books;
    }


    public static void main(String[] args) {
        bookDB book = new bookDB();
        List<Book> books = book.getRecord();

    }
    
}//end bookdb