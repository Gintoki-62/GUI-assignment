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
import java.util.ArrayList;
import java.util.List;

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
        request.setCharacterEncoding("UTF-8");
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

        List<String> errorMessages = new ArrayList<>();

        // Data validation
        if (bookName == null || bookName.trim().isEmpty()) {
            errorMessages.add("Book Name is required.");
        }

        try {
            bookPrice = Double.parseDouble(request.getParameter("bookPrice"));
            if (bookPrice == null || bookPrice <= 0) {
                errorMessages.add("Price must be greater than zero.");
            }
        } catch (NumberFormatException e) {
            errorMessages.add("Invalid price format.");
        }

        if (authorName == null || authorName.trim().isEmpty()) {
            errorMessages.add("Author Name is required.");
        }

        try {
            String pagesStr = request.getParameter("noOfPages");
            if (pagesStr != null && !pagesStr.isEmpty()) {
                noOfPages = Integer.parseInt(pagesStr);
                if (noOfPages < 0) {
                    errorMessages.add("Number of pages cannot be negative.");
                }
            } else {
                noOfPages = 0;
            }
        } catch (NumberFormatException e) {
            errorMessages.add("Invalid number of pages format.");
        }

        try {
            bookQuantity = Integer.parseInt(request.getParameter("bookQuantity"));
            if (bookQuantity < 0) {
                errorMessages.add("Quantity cannot be negative.");
            }
        } catch (NumberFormatException e) {
            errorMessages.add("Invalid quantity format.");
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

        if (!errorMessages.isEmpty()) {
            request.setAttribute("errorMessages", errorMessages); // Set the list of errors
            request.getRequestDispatcher("staffAddProd.jsp").forward(request, response);
            return;
        }

        Book newBook = new Book(bookId, bookName, bookPrice, authorName, publisher, noOfPages, bookDesc, bookQuantity, bookType, bookImage, bookCategory);

        try {
            boolean added = staffDb.addBook(newBook);
            if (added) {
                request.setAttribute("successMessage", "Product added successfully!");
                request.setAttribute("bookId", bookId);
                request.getRequestDispatcher("staffAddProd.jsp").forward(request, response);
            } else {
                errorMessages.add("Failed to add product."); // Add a general error message
                request.setAttribute("errorMessages", errorMessages);
                request.getRequestDispatcher("staffAddProd.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            errorMessages.add("Database error: " + e.getMessage()); // Add the database error
            request.setAttribute("errorMessages", errorMessages);
            request.getRequestDispatcher("staffAddProd.jsp").forward(request, response);
        }
    }
}