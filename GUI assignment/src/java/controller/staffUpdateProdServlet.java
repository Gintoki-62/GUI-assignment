package controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DB.bookDB;
import domain.Book;

@WebServlet("/staffUpdateProdServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10)
public class staffUpdateProdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String bookId = request.getParameter("BOOK_ID");
        String bookName = request.getParameter("BOOK_NAME");
        String bookPriceStr = request.getParameter("BOOK_PRICE");
        String authorName = request.getParameter("AUTHOR_NAME");
        String publisher = request.getParameter("PUBLISHER");
        String noOfPagesStr = request.getParameter("NO_OF_PAGES");
        String bookDesc = request.getParameter("BOOK_DESC");
        String bookQuantityStr = request.getParameter("BOOK_QUANTITY");
        String bookType = request.getParameter("BOOK_TYPE");
        String bookCategory = request.getParameter("BOOK_CATEGORY");

        double bookPrice = 0.0;
        int noOfPages = 0;
        int bookQuantity = 0;
        String bookImage = null;
        boolean hasError = false;
        String errorMessage = "";

        // 1. Data Validation
        if (bookId == null || bookId.trim().isEmpty()) {
            hasError = true;
            errorMessage += "Book ID cannot be empty.<br>";
        }
        if (bookName == null || bookName.trim().isEmpty()) {
            hasError = true;
            errorMessage += "Book Name cannot be empty.<br>";
        }
        try {
            bookPrice = Double.parseDouble(bookPriceStr);
            if (bookPrice <= 0) {
                hasError = true;
                errorMessage += "Price must be a positive value.<br>";
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorMessage += "Invalid price format.<br>";
        }
        try {
            if (noOfPagesStr != null && !noOfPagesStr.trim().isEmpty()) {
                noOfPages = Integer.parseInt(noOfPagesStr);
                if (noOfPages < 0) {
                    hasError = true;
                    errorMessage += "Number of pages cannot be negative.<br>";
                }
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorMessage += "Invalid number of pages format.<br>";
        }
        try {
            bookQuantity = Integer.parseInt(bookQuantityStr);
            if (bookQuantity < 0) {
                hasError = true;
                errorMessage += "Quantity cannot be negative.<br>";
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorMessage += "Invalid quantity format.<br>";
        }
        if (bookType == null || bookType.trim().isEmpty()) {
            hasError = true;
            errorMessage += "Book Type cannot be empty.<br>";
        }
        if (bookCategory == null || bookCategory.trim().isEmpty()) {
            hasError = true;
            errorMessage += "Book Category cannot be empty.<br>";
        }

        if (hasError) {
            request.setAttribute("errorMessage", errorMessage);
            // Re-populate the form with the submitted values
            request.setAttribute("book", new Book(bookId, bookName, bookPrice, authorName, publisher, noOfPages, bookDesc, bookQuantity, bookType, null, bookCategory));
            request.getRequestDispatcher("staffEditProd.jsp").forward(request, response);
            return;
        }

        //Handle Image Upload
        Part filePart = request.getPart("BOOK_IMAGE");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        InputStream fileContent = filePart.getInputStream();

        //See if a new image was uploaded
        if (fileName != null && !fileName.isEmpty() && fileContent.available() > 0) {
            String uploadDirectory = getServletContext().getRealPath("images/book");
            String newImagePath = uploadDirectory + "/" + fileName;

            try {
                Files.copy(fileContent, Paths.get(newImagePath), StandardCopyOption.REPLACE_EXISTING);
                bookImage = "images/book" + fileName;
            } catch (IOException e) {
                // Handle image upload error
                e.printStackTrace();
                request.setAttribute("errorMessage", "Error uploading the new image.");
                request.setAttribute("book", new Book(bookId, bookName, bookPrice, authorName, publisher, noOfPages, bookDesc, bookQuantity, bookType, null, bookCategory));
                request.getRequestDispatcher("staffEditProd.jsp").forward(request, response);
                return;
            }
        } else {
            // If no new image, retrieve the existing image path from the database
            bookDB bookDb = new bookDB();
            Book existingBook = bookDb.getBookById(bookId);
            if (existingBook != null) {
                bookImage = existingBook.getBOOK_IMAGE();
            }
        }

        //Update database adwdda
        Book updatedBook = new Book(bookId, bookName, bookPrice, authorName, publisher, noOfPages, bookDesc, bookQuantity, bookType, bookImage, bookCategory);
        bookDB bookDb = new bookDB();

        try {
            boolean updated = bookDb.updateBook(updatedBook);
            if (updated) {
                //redirect to staff index if success
                response.sendRedirect("staffViewProd.jsp?updateSuccess=true");
            } else {
                //Handle database update failure
                request.setAttribute("errorMessage", "Error updating the book in the database.");
                request.setAttribute("book", updatedBook);
                request.getRequestDispatcher("staffEditProd.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error occurred: " + e.getMessage());
            request.setAttribute("book", updatedBook);
            request.getRequestDispatcher("staffEditProd.jsp").forward(request, response);
        }
    }
}