/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import DB.ProductDB;
import domain.Product;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author User
 */
public class editProductServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
        
        int Quantity = Integer.parseInt(quantity);
        double Price = Double.parseDouble(priceStr);
        int No_pages = Integer.parseInt(no_pages);
        
        Product prd = new Product();
        prd.setBookId(id);
        prd.setBookName(name);
        prd.setPrice(Price);
        prd.setAuthor(author);
        prd.setPublisher(publisher);
        prd.setNoPages(No_pages);
        prd.setDescription(desc);
        prd.setQuantity(Quantity);
        prd.setType(type);
        prd.setCategory(category);

        try {
            ProductDB db = new ProductDB();
            db.updateRecord(prd);  // you can also use updateStaffAccount()
            
            // response.sendRedirect("AddStaffAccount.jsp");
            request.setAttribute("bookName", name);
            request.getRequestDispatcher("editProduct.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.getWriter().println("Update failed: " + e.getMessage());
        }
    }


}
