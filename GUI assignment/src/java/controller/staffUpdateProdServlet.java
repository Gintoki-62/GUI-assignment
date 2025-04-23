package controller;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import DB.staffDB;
import domain.Book;

@WebServlet("/staffUpdateProdServlet")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10)
public class staffUpdateProdServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

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
        List<String> errorMessages = new ArrayList<>();

        // 1. Data Validation
        if (bookId == null || bookId.trim().isEmpty()) {
            hasError = true;
            errorMessages.add("Book ID cannot be empty.");
        }
        if (bookName == null || bookName.trim().isEmpty()) {
            hasError = true;
            errorMessages.add("Book Name cannot be empty.");
        } else if (bookName.length() > 255) {
            hasError = true;
            errorMessages.add("Book Name cannot exceed 255 characters.");
        }
        try {
            bookPrice = Double.parseDouble(bookPriceStr);
            if (bookPrice <= 0) {
                hasError = true;
                errorMessages.add("Price must be a positive value.");
            } else if (bookPrice > 99999.99) {
                hasError = true;
                errorMessages.add("Price cannot exceed 99999.99.");
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorMessages.add("Invalid price format.");
        }
        if (authorName == null || authorName.trim().isEmpty()) {
            hasError = true;
            errorMessages.add("Author Name cannot be empty.");
        } else if (authorName.length() > 255) {
            hasError = true;
            errorMessages.add("Author Name cannot exceed 255 characters.");
        }
        if (publisher == null || publisher.trim().isEmpty()) {
            hasError = true;
            errorMessages.add("Publisher cannot be empty.");
        } else if (publisher.length() > 255) {
            hasError = true;
            errorMessages.add("Publisher cannot exceed 255 characters.");
        }
        try {
            if (noOfPagesStr != null && !noOfPagesStr.trim().isEmpty()) {
                noOfPages = Integer.parseInt(noOfPagesStr);
                if (noOfPages < 0) {
                    hasError = true;
                    errorMessages.add("Number of pages cannot be negative.");
                } else if (noOfPages > 9999) {
                    hasError = true;
                    errorMessages.add("Number of pages cannot exceed 9999.");
                }
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorMessages.add("Invalid number of pages format.");
        }
        if (bookDesc == null || bookDesc.trim().isEmpty()) {
            hasError = true;
            errorMessages.add("Book Description cannot be empty.");
        } else {
            String[] words = bookDesc.trim().split("\\s+");
            if (words.length > 500) {
                hasError = true;
                errorMessages.add("Book Description cannot exceed 500 words.");
            }
        }
        try {
            bookQuantity = Integer.parseInt(bookQuantityStr);
            if (bookQuantity < 0) {
                hasError = true;
                errorMessages.add("Quantity cannot be negative.");
            } else if (bookQuantity > 9999) {
                hasError = true;
                errorMessages.add("Quantity cannot exceed 9999.");
            }
        } catch (NumberFormatException e) {
            hasError = true;
            errorMessages.add("Invalid quantity format.");
        }
        if (bookType == null || bookType.trim().isEmpty()) {
            hasError = true;
            errorMessages.add("Book Type cannot be empty.");
        } else if (bookType.length() > 50) {
            hasError = true;
            errorMessages.add("Book Type cannot exceed 50 characters.");
        }
        if (bookCategory == null || bookCategory.trim().isEmpty()) {
            hasError = true;
            errorMessages.add("Book Category cannot be empty.");
        } else if (bookCategory.length() > 50) {
            hasError = true;
            errorMessages.add("Book Category cannot exceed 50 characters.");
        }

        if (hasError) {
            request.setAttribute("errorMessages", errorMessages);
            request.setAttribute("book", new Book(bookId, bookName, bookPrice, authorName, publisher, noOfPages, bookDesc, bookQuantity, bookType, null, bookCategory));
            request.getRequestDispatcher("staffEditProd.jsp").forward(request, response);
            return;
        }

        // Handle Image Upload
        Part filePart = request.getPart("BOOK_IMAGE");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        InputStream fileContent = filePart.getInputStream();

        if (fileName != null && !fileName.isEmpty() && fileContent.available() > 0) {
            String uploadDirectory = getServletContext().getRealPath("images/book/");
            String newImagePath = uploadDirectory + "/" + fileName;

            try {
                Files.copy(fileContent, Paths.get(newImagePath), StandardCopyOption.REPLACE_EXISTING);
                bookImage = "images/book/" + fileName;
            } catch (IOException e) {
                e.printStackTrace();
                errorMessages.add("Error uploading the new image.");
                request.setAttribute("errorMessages", errorMessages);
                request.setAttribute("book", new Book(bookId, bookName, bookPrice, authorName, publisher, noOfPages, bookDesc, bookQuantity, bookType, null, bookCategory));
                request.getRequestDispatcher("staffEditProd.jsp").forward(request, response);
                return;
            }
        } else {
            staffDB staffDb = new staffDB();
            Book existingBook = staffDb.getBookById(bookId);
            if (existingBook != null) {
                bookImage = existingBook.getBOOK_IMAGE();
            }
        }

        // Update database
        Book updatedBook = new Book(bookId, bookName, bookPrice, authorName, publisher, noOfPages, bookDesc, bookQuantity, bookType, bookImage, bookCategory);
        staffDB staffDb = new staffDB();

        try {
            boolean updated = staffDb.updateBook(updatedBook);
            if (updated) {
                request.setAttribute("successMessage", "Product updated successfully!");
                request.setAttribute("book", updatedBook);
                request.setAttribute("bookId", bookId);
                request.getRequestDispatcher("staffEditProd.jsp?BOOK_ID=" + bookId).forward(request, response);
            } else {
                // Handle database update failure
                errorMessages.add("Error updating the book in the database.");
                request.setAttribute("errorMessages", errorMessages);
                request.setAttribute("book", updatedBook);
                request.getRequestDispatcher("staffEditProd.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorMessages.add("Database error occurred: " + e.getMessage());
            request.setAttribute("errorMessages", errorMessages);
            request.setAttribute("book", updatedBook);
            request.getRequestDispatcher("staffEditProd.jsp").forward(request, response);
        }
    }
}