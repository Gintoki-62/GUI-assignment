package controller;

import DB.staffDB;
import domain.Book;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.SQLException;

@WebServlet("/addBook")
@MultipartConfig(fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 5,
        maxRequestSize = 1024 * 1024 * 10)
public class staffAddProdServlet extends HttpServlet {

    private staffDB staffDb;

    @Override
    public void init() throws ServletException {
        staffDb = new staffDB();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookId = request.getParameter("bookId");
        String bookName = request.getParameter("bookName");
        String authorName = request.getParameter("authorName");
        String publisher = request.getParameter("publisher");
        String bookDesc = request.getParameter("bookDesc");
        String bookType = request.getParameter("bookType");
        String bookCategory = request.getParameter("bookCategory");

        Double bookPrice = null;
        Integer noOfPages = null;
        Integer bookQuantity = null;
        String bookImage = "";

        boolean hasErrors = false;
        String errorMessage = "";

        // Data validation
        if (bookName == null || bookName.trim().isEmpty()) {
            errorMessage += "Book Name is required.<br>";
            hasErrors = true;
        }

        try {
            bookPrice = Double.parseDouble(request.getParameter("bookPrice"));
            if (bookPrice <= 0) {
                errorMessage += "Price must be greater than zero.<br>";
                hasErrors = true;
            }
        } catch (NumberFormatException e) {
            errorMessage += "Invalid price format.<br>";
            hasErrors = true;
        }

        if (authorName == null || authorName.trim().isEmpty()) {
            errorMessage += "Author Name is required.<br>";
            hasErrors = true;
        }

        try {
            String pagesStr = request.getParameter("noOfPages");
            if (pagesStr != null && !pagesStr.isEmpty()) {
                noOfPages = Integer.parseInt(pagesStr);
                if (noOfPages < 0) {
                    errorMessage += "Number of pages cannot be negative.<br>";
                    hasErrors = true;
                }
            } else {
                noOfPages = 0;
            }
        } catch (NumberFormatException e) {
            errorMessage += "Invalid number of pages format.<br>";
            hasErrors = true;
        }

        try {
            bookQuantity = Integer.parseInt(request.getParameter("bookQuantity"));
            if (bookQuantity < 0) {
                errorMessage += "Quantity cannot be negative.<br>";
                hasErrors = true;
            }
        } catch (NumberFormatException e) {
            errorMessage += "Invalid quantity format.<br>";
            hasErrors = true;
        }

        // Handle image upload
        Part filePart = request.getPart("bookImage");

        if (filePart != null && filePart.getSize() > 0) {
            String submittedFileName = filePart.getSubmittedFileName();
            if (submittedFileName != null && !submittedFileName.isEmpty()) {
                String fileName = Paths.get(submittedFileName).getFileName().toString();
                String uploadDirectory = getServletContext().getRealPath("images/book/");

                Files.createDirectories(Paths.get(uploadDirectory));

                InputStream fileContent = filePart.getInputStream();
                Files.copy(fileContent, Paths.get(uploadDirectory, fileName), StandardCopyOption.REPLACE_EXISTING);
                bookImage = "images/book/" + fileName;
            }
        }

        if (hasErrors) {
            request.setAttribute("errorMessage", errorMessage);
            request.getRequestDispatcher("staffAddProd.jsp").forward(request, response);
            return;
        }

        Book newBook = new Book(bookId, bookName, bookPrice, authorName, publisher, noOfPages, bookDesc, bookQuantity, bookType, bookImage, bookCategory);

        try {
            boolean added = staffDb.addBook(newBook);
            if (added) {
                request.setAttribute("successMessage", "Product added successfully!");
                request.getRequestDispatcher("staffAddProd.jsp").forward(request, response);
            } else {
                request.setAttribute("errorMessage", "Failed to add product.");
                request.getRequestDispatcher("staffAddProd.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffAddProd.jsp").forward(request, response);
        }
    }
}