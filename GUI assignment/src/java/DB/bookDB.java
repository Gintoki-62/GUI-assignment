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
    
    public ResultSet getCart(String userId) {
        ResultSet rs = null;
        try {
            String sql = "SELECT c.BOOK_ID, b.BOOK_NAME, b.BOOK_PRICE, b.BOOK_IMAGE, c.QUANTITY, b.BOOK_TYPE, b.BOOK_CATEGORY " +
                        "FROM CART c " +
                        "JOIN BOOK b ON c.BOOK_ID = b.BOOK_ID " +
                        "WHERE c.user_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            rs = stmt.executeQuery();
            
        } catch (SQLException ex) {
            System.err.println("Error fetching records: " + ex.getMessage());
        }
        return rs;
    }
    
    public String CreateCartId(String userId) {
        String prefix = "25CART";
        int nextNumber = 1;
        ResultSet rs = null;
        String cartId = null;
        
        try {
            // 1. Check if user already has a cart
            String checkSql = "SELECT CART_ID FROM CART WHERE user_id = ?";
            stmt = conn.prepareStatement(checkSql);
            stmt.setString(1, userId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("CART_ID"); // Return existing
            }
            rs.close();
            stmt.close();

            // 2. Generate new cartId
            String getLastSql = "SELECT CART_ID FROM CART ORDER BY CART_ID DESC LIMIT 1";
            stmt = conn.prepareStatement(getLastSql);
            rs = stmt.executeQuery();
            if (rs.next()) {
                String lastId = rs.getString("CART_ID");
                String numPart = lastId.substring(prefix.length()); // e.g., 00001
                nextNumber = Integer.parseInt(numPart) + 1;
            }

            // 3. Format new ID
            cartId = String.format("%04d", nextNumber); // e.g., 25CART00002

            // 4. Insert new cart record
            String insertSql = "INSERT INTO cart (CART_ID, user_id) VALUES (?, ?)";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, cartId);
            stmt.setString(2, userId);
            stmt.executeUpdate();
            conn.commit();

        } catch (SQLException ex) {
            System.err.println("Error creating cart ID: " + ex.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception ignored) {}
            try { if (stmt != null) stmt.close(); } catch (Exception ignored) {}
        }

        return cartId;
    }

    public void addToCart(String userId, String bookId, String cartId, int quantity) throws Exception {
        ResultSet rs = null;
        try {
            String bookName="", bookImage="";
            Double bookPrice;
            
            String bookQuery = "SELECT book_name, book_image, book_price FROM book WHERE book_id = ?";
            stmt = conn.prepareStatement(bookQuery);
            stmt.setString(1, bookId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                bookName = rs.getString("book_name");
                bookImage = rs.getString("book_image");
                bookPrice = rs.getDouble("book_price");
            } else {
                throw new Exception("Book not found");
            }

            rs.close();
            stmt.close();

            // 3. Check if book already in user's cart
            String checkCartSql = "SELECT quantity FROM cart WHERE user_id = ? AND book_id = ?";
            stmt = conn.prepareStatement(checkCartSql);
            stmt.setString(1, userId);
            stmt.setString(2, bookId);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Book already in cart → update quantity
                int existingQty = rs.getInt("quantity");
                rs.close();
                stmt.close();

                String updateSql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND book_id = ?";
                stmt = conn.prepareStatement(updateSql);
                stmt.setInt(1, existingQty + quantity);
                stmt.setString(2, userId);
                stmt.setString(3, bookId);
                stmt.executeUpdate();
            } else {
                // Not in cart → insert new row
                rs.close();
                stmt.close();

                String insertSql = "INSERT INTO cart (cart_id, user_id, book_id, book_name, book_image, book_price, quantity) " +
                                   "VALUES (?, ?, ?, ?, ?, ?, ?)";
                stmt = conn.prepareStatement(insertSql);
                stmt.setString(1, cartId);
                stmt.setString(2, userId);
                stmt.setString(3, bookId);
                stmt.setString(4, bookName);
                stmt.setString(5, bookImage);
                stmt.setDouble(6, bookPrice);
                stmt.setInt(7, quantity);
                stmt.executeUpdate();
            }

        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignored) {}
            if (stmt != null) try { stmt.close(); } catch (Exception ignored) {}
            if (conn != null) try { conn.close(); } catch (Exception ignored) {}
        }
    }



    public static void main(String[] args) {
        bookDB book = new bookDB();
        List<Book> books = book.getRecord();
    }
    
}//end bookdb