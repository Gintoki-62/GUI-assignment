package controller;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import domain.Customer;
import DB.CustomerDB;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.annotation.WebServlet;

@WebServlet("/staffSearchCustServlet")
public class staffSearchCustServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String searchTerm = request.getParameter("searchTerm");
        List<Customer> searchResults = new ArrayList<>();
        CustomerDB customerDB = null;
        ResultSet rs = null;

        try {
            customerDB = new CustomerDB();
            rs = customerDB.searchCustomers(searchTerm);

            while (rs.next()) {
                int customerId = rs.getInt("ID");
                Customer customer = customerDB.getCustomerById(String.valueOf(customerId));
                searchResults.add(customer);
            }

            request.setAttribute("searchResults", searchResults);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error during search: " + e.getMessage());
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (customerDB != null) {
                try {
                    customerDB.shutDown();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("staffCustRecord.jsp");
        dispatcher.forward(request, response);
    }
}