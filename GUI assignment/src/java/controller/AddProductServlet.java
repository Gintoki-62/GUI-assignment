/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.ProductDB;
import domain.Product;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import javax.servlet.annotation.MultipartConfig;

/**
 *
 * @author User
 */
@MultipartConfig
public class AddProductServlet extends HttpServlet {

    private ProductDB prd;
    
    @Override
    public void init() throws ServletException {
        try {
            prd = new ProductDB();
        } catch (Exception ex) {
            Logger.getLogger(AddProductServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }
    
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();
    request.setCharacterEncoding("UTF-8");

    Part filePart = request.getPart("image"); // For uploaded image
    String imagePath = null;

    if (filePart != null && filePart.getSize() > 0) {
        String submittedFileName = filePart.getSubmittedFileName();
        if (submittedFileName != null && !submittedFileName.isEmpty()) {
            String fileName = Paths.get(submittedFileName).getFileName().toString();
            String uploadDirectory = getServletContext().getRealPath("images/book/");
            Files.createDirectories(Paths.get(uploadDirectory));

            InputStream fileContent = filePart.getInputStream();
            Files.copy(fileContent, Paths.get(uploadDirectory, fileName), StandardCopyOption.REPLACE_EXISTING);
            imagePath = "images/book/" + fileName;
        }
    }

    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String author = request.getParameter("author");
    String publisher = request.getParameter("publisher");
    String desc = request.getParameter("desc");
    String no_pages = request.getParameter("no_pages");
    String category = request.getParameter("category");
    String type = request.getParameter("type");
    String priceStr = request.getParameter("price").replace("RM ", "").trim();
    String quantity = request.getParameter("quantity");

    try {
        int Quantity = Integer.parseInt(quantity);
        double Price = Double.parseDouble(priceStr);
        int No_pages = Integer.parseInt(no_pages);

        Product p = new Product(id, name, Price, author, publisher, No_pages, desc, Quantity, type, imagePath, category);
        prd.addRecord(p);

        request.setAttribute("bookName", name);
        request.getRequestDispatcher("AddProduct.jsp").forward(request, response);

    } catch (Exception ex) {
        out.println(ex.getMessage());
    } finally {
        out.close();
    }
}

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */


}

