package DB;

import domain.Book;
import java.util.List;
import java.util.ArrayList;
import java.sql.*;

public class staffDB {
    private String host = "jdbc:derby://localhost:1527/bookLoomDB";
    private String user = "book";
    private String password = "book";
    private String tableName = "BOOK";
    private Connection conn;
    private PreparedStatement stmt;

    public staffDB() {
        createConnection();
    }
    
    private void createConnection() {
        try {
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            conn = DriverManager.getConnection(host + ";create=true;encoding=UTF-8", user, password);
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
    
    public Book getBookById(String bookId) {
        Book book = null;
        String queryStr = "SELECT * FROM " + tableName + " WHERE BOOK_ID = ?";

        try {
            stmt = conn.prepareStatement(queryStr);
            stmt.setString(1, bookId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                book = new Book(
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
            }
        } catch (SQLException ex) {
            System.err.println("Error fetching book with ID " + bookId + ": " + ex.getMessage());
        }
        return book;
    }
    
    //update book in staff edit prod
    public boolean updateBook(Book book) throws SQLException {
        PreparedStatement preparedStatement = null;
        boolean updated = false;

        try {
            String sql = "UPDATE BOOK SET " +
                         "BOOK_NAME = ?, " +
                         "BOOK_PRICE = ?, " +
                         "AUTHOR_NAME = ?, " +
                         "PUBLISHER = ?, " +
                         "NO_OF_PAGES = ?, " +
                         "BOOK_DESC = ?, " +
                         "BOOK_QUANTITY = ?, " +
                         "BOOK_TYPE = ?, " +
                         "BOOK_IMAGE = ?, " +
                         "BOOK_CATEGORY = ? " +
                         "WHERE BOOK_ID = ?";

            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, book.getBOOK_NAME());
            preparedStatement.setDouble(2, book.getBOOK_PRICE());
            preparedStatement.setString(3, book.getAUTHOR_NAME());
            preparedStatement.setString(4, book.getPUBLISHER());
            preparedStatement.setInt(5, book.getNO_OF_PAGES());
            preparedStatement.setString(6, book.getBOOK_DESC());
            preparedStatement.setInt(7, book.getBOOK_QUANTITY());
            preparedStatement.setString(8, book.getBOOK_TYPE());
            preparedStatement.setString(9, book.getBOOK_IMAGE());
            preparedStatement.setString(10, book.getBOOK_CATEGORY());
            preparedStatement.setString(11, book.getBOOK_ID());

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                updated = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return updated;
    }
    
    //add book method
    public boolean addBook(Book book) throws SQLException {
        PreparedStatement preparedStatement = null;
        boolean added = false;

        try {
            String sql = "INSERT INTO BOOK (BOOK_ID, BOOK_NAME, BOOK_PRICE, AUTHOR_NAME, PUBLISHER, NO_OF_PAGES, BOOK_DESC, BOOK_QUANTITY, BOOK_TYPE, BOOK_IMAGE, BOOK_CATEGORY) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            preparedStatement = conn.prepareStatement(sql);
            preparedStatement.setString(1, book.getBOOK_ID());
            preparedStatement.setString(2, book.getBOOK_NAME());
            preparedStatement.setDouble(3, book.getBOOK_PRICE());
            preparedStatement.setString(4, book.getAUTHOR_NAME());
            preparedStatement.setString(5, book.getPUBLISHER());
            preparedStatement.setInt(6, book.getNO_OF_PAGES());
            preparedStatement.setString(7, book.getBOOK_DESC());
            preparedStatement.setInt(8, book.getBOOK_QUANTITY());
            preparedStatement.setString(9, book.getBOOK_TYPE());
            preparedStatement.setString(10, book.getBOOK_IMAGE());
            preparedStatement.setString(11, book.getBOOK_CATEGORY());

            int rowsAffected = preparedStatement.executeUpdate();
            if (rowsAffected > 0) {
                added = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return added;
    }
    
    //auto generate id
    public String generateNextBookId() {
        String nextId = "25BOK00001";
        PreparedStatement preparedStatement = null;
        ResultSet resultSet = null;

        try {
            if (conn == null || conn.isClosed()) {
                createConnection();
            }

            String sql = "SELECT MAX(SUBSTR(BOOK_ID, 6)) AS max_suffix FROM BOOK WHERE SUBSTR(BOOK_ID, 1, 5) = '25BOK'";
            preparedStatement = conn.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                String maxSuffixStr = resultSet.getString("max_suffix");
                if (maxSuffixStr != null) {
                    try {
                        int maxSuffix = Integer.parseInt(maxSuffixStr);
                        int nextSuffix = maxSuffix + 1;
                        nextId = String.format("25BOK%05d", nextSuffix);
                    } catch (NumberFormatException e) {
                        System.err.println("Error parsing book ID suffix: " + e.getMessage());
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error generating next book ID: " + e.getMessage());
        } finally {
            if (resultSet != null) {
                try {
                    resultSet.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (preparedStatement != null) {
                try {
                    preparedStatement.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return nextId;
    }
    
    public static void main(String[]args){
        staffDB stf = new staffDB();
    }
}