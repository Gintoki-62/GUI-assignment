/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import domain.Book;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

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
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host, user, password);
            System.out.println("***TRACE: Connection established.");
        } catch (Exception ex) {
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
            String sql = "SELECT * FROM BOOK WHERE LOWER(BOOK_NAME) LIKE ? OR LOWER(AUTHOR_NAME) LIKE ?";
            stmt = conn.prepareStatement(sql);
            String likeTerm = "%" + searchTerm.toLowerCase() + "%";
            stmt.setString(1, likeTerm);
            stmt.setString(2, likeTerm);

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
                books.add(book);
            }
        } catch (SQLException ex) {
            System.err.println("Search error: " + ex.getMessage());
        }
        return books;
    }
    
    public int getTotalBooksInCart(String userId) {
        int total = 0;
        ResultSet rs;
        try {
            stmt = conn.prepareStatement("SELECT COUNT(*) FROM cart WHERE user_id = ?");
            stmt.setString(1, userId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }   
        } catch (SQLException ex) {
            System.err.println("Error count total book in Cart: " + ex.getMessage());
        }
        return total;
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
        String cartId = null;
        ResultSet rs = null;

        try {
            // 1. Check if user already has a cart
            String checkSql = "SELECT CART_ID FROM CART WHERE user_id = ?";
            stmt = conn.prepareStatement(checkSql);
            stmt.setString(1, userId);
            rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getString("CART_ID"); // Already exists
            }
            rs.close();
            stmt.close();

            // 2. Find the latest CART_ID (descending order)
            String lastIdSql = "SELECT CART_ID FROM CART WHERE CART_ID LIKE ? ORDER BY CART_ID DESC FETCH FIRST 1 ROWS ONLY";
            stmt = conn.prepareStatement(lastIdSql);
            stmt.setString(1, prefix + "%");
            rs = stmt.executeQuery();

            if (rs.next()) {
                String lastId = rs.getString("CART_ID");
                String numPart = lastId.substring(prefix.length()); // Get the numeric part
                nextNumber = Integer.parseInt(numPart) + 1;
            }
            rs.close();
            stmt.close();

            // 3. Format new CART_ID (e.g., 25CART0001)
            cartId = prefix + String.format("%04d", nextNumber);

            // 4. Insert new cart
            String insertSql = "INSERT INTO CART (CART_ID, user_id) VALUES (?, ?)";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, cartId);
            stmt.setString(2, userId);
            stmt.executeUpdate();

        } catch (SQLException e) {
            System.err.println("SQL Error: " + e.getMessage());
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
        }
    }

    public void updateQuantity(String userId, String bookId, int quantity){
        String sql = "UPDATE CART SET QUANTITY = ? WHERE USER_ID = ? AND BOOK_ID = ?";
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, quantity);
            stmt.setString(2, userId);
            stmt.setString(3, bookId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(bookDB.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void removeFromCart(String userId, String bookId){
        String sql = "DELETE FROM cart WHERE user_id = ? AND book_id = ?";
        try {
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, userId);
            stmt.setString(2, bookId);
            stmt.executeUpdate();
        } catch (SQLException ex) {
             System.err.println("Error remove Cart: " + ex.getMessage());
        }
    }



    public static void main(String[] args) {
        bookDB book = new bookDB();
        List<Book> books = book.getRecord();
    }
    
}//end bookdb